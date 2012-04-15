# ==== Installation
# 
#   1. bundle install --gemfile=_Gemfile (if bundler isn't installed: gem install bundler)
#   2. Download Google Closure jar: 
#      http://closure-compiler.googlecode.com/files/compiler-latest.zip
#   3. Download htmlcompressor jar, place in same directory as Closure jar.
#      http://code.google.com/p/htmlcompressor/
#   4. Install optipng for optimizing PNGs (brew install optipng)
#   5. Install s3cmd to upload to Amazon S3 (brew install s3cmd, s3cmd --configure)
#
# ==== Configuration
#
#   - change constants in Deploy class as appropriate for Amazon bucket name and server IP
#
# ==== Usage
#
#   Build and serve on local machine:
#     thor build
#
#   Build and deploy to production:
#     thor deploy
#
#   Specify different location for htmlcompressor:
#     thor build --compressor=[COMPRESSOR LOCATION]
#
#   List all tasks:
#     thor list
#
#   Show help for one task:
#     thor help [TASK]
#

class Build < Thor  
  BUILD_DIR = "_site/"
  LIBS_DIR = "_libs/"
  SASS_DIR = "styles"
  CSS_DIR = "css"
  class_option :compressor, :default => "../_libs/htmlcompressor-1.5.3.jar"

  default_task :server

  def self.build_dir
    BUILD_DIR
  end

  def self.libs_dir
    LIBS_DIR
  end

  def self.sass_dir
    SASS_DIR
  end

  def self.css_dir
    CSS_DIR
  end

  desc "optimize_images", "optimize all PNGs"
  def optimize_images
    system "ruby #{LIBS_DIR}optimize_images.rb #{BUILD_DIR}"
  end

  desc "clean", "cleans build directory", :hide => true
  def clean
    puts "cleaning build dir #{BUILD_DIR}"
    system "rm -rf #{BUILD_DIR}*"
  end

  desc "jekyll", "builds static site", :hide => true
  def jekyll
    puts "building static site with jekyll"
    system "jekyll #{BUILD_DIR} --pygments --no-future"
  end

  desc "compass", "compile css with compass", :hide => true
  # method_option :sass_dir, :default => "styles", :required => true
  def compass(environment = "development", output_style = "expanded")
    puts "compiling css with compass"
    system "compass compile --sass-dir #{SASS_DIR} --css-dir #{CSS_DIR} -e #{environment} -s #{output_style} --force"
  end

  desc "less", "compile css with less", :hide => true
  def less
    puts "compiling css with less"
    system "lessc bootstrap/less/bootstrap.less > _includes/bootstrap.css"
    system "lessc _includes/screen.less > _includes/screen.css"
  end

  desc "javascript_compile", "uses Uglifier to optimize javascript", :hide => true
  def javascript_compile
    puts "optimizing JavaScript with Uglifier"
    system "ruby #{LIBS_DIR}javascript_compile.rb #{BUILD_DIR}"
  end

  desc "version_static_content", "version and replace static content", :hide => true
  def version_static_content(cdn = "")
    puts "versioning static content"
    system "ruby #{LIBS_DIR}version_static_content.rb #{BUILD_DIR} #{cdn}"
  end

  desc "add_base_path", "adds a base path to all files referenced by links or elsewhere", :hide => true
  def add_base_path
    path = BUILD_DIR
    # return everything after first occurance of /
    path = path.slice(path.index('/')..-1)
    # remove trailing /
    path.chop! if path.end_with?('/')
    unless path.empty?
      puts "adding a base path to all files"
      system "ruby #{LIBS_DIR}add_base_path.rb #{BUILD_DIR} #{path}"
    end
  end

  desc "html_compress", "minifies all html", :hide => true
  def html_compress
    puts "minifying all html"
    system "ruby #{LIBS_DIR}html_compress.rb #{BUILD_DIR} #{options[:compressor]}"
  end

  desc "testing", "builds and prepares site for a testing environment"
  def testing
    invoke :clean
    invoke :less
    invoke :jekyll
    invoke :javascript_compile
    invoke :version_static_content
    invoke :add_base_path
    invoke :html_compress
  end

  desc "server", "builds, prepares, and hosts site locally using thin"
  method_option :port, :aliases => "-p", :default => 3000
  def server
    invoke :testing
    system "thin start -R #{LIBS_DIR}thin.ru -p #{options[:port]}"
  end

  # thor 0.14.6 has a bug that forces args to be defined for invoked tasks if the main task accepts an argument that isn't optional.
  # for example, if you remove the [] for `invoke :jekyll, []`, you'll receive an error that the jekyll task was called incorrectly.
  desc "production", "builds and prepares site for a production environment"
  def production(cdn)
    invoke :clean, []
    invoke :less, []
    invoke :jekyll, []
    invoke :javascript_compile, []
    invoke :version_static_content, [cdn]
    invoke :add_base_path, []
    invoke :html_compress, []
  end
end
