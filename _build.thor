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
#
#TODO: use this command somewhere before static assets are versioned
	#python -c "from slimmer import css_slimmer; import sys; print css_slimmer(open('_site/css/main.css').read())" > _site/css/compressed_main.css

class Build < Thor  
  BUILD_DIR = "_site/"
  LIBS_DIR = "_libs/"
  SASS_DIR = "_includes/sass"
  CSS_DIR = "_includes"
  class_option :compressor, :default => "../_libs/htmlcompressor-1.5.3.jar"

  default_task :testing

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

  desc "jekylldev", "builds static site", :hide => true
  def jekylldev
    puts "serving static site with jekyll"
    system "jekyll #{BUILD_DIR} --no-future --server"
  end

  desc "jekyll", "builds static site", :hide => true
  def jekyll
    puts "building static site with jekyll"
    system "jekyll #{BUILD_DIR} --pygments --no-future"
  end

  desc "compass", "compile css with compass", :hide => true
  # method_option :sass_dir, :default => "_includes/sass", :required => true
  def compass(environment = "development", output_style = "expanded")
    puts "compiling css with compass"
    system "compass compile --sass-dir #{SASS_DIR} --css-dir #{CSS_DIR} -e #{environment} -s #{output_style} --force"
  end

  desc "less", "compile css with less", :hide => true
  def less
    puts "compiling css with less"
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

  desc "bipartite", "minifies css using a genetic algorithm", :hide => true
  def bipartite
    puts "bipartite algorithm running on CSS"
    system "python #{LIBS_DIR}css_bipartite/css.py -g 1 #{CSS_DIR}/pygments.css #{CSS_DIR}/screen.css #{CSS_DIR}/text.css -o #{CSS_DIR}/bp.css"
  end

  desc "css_compress", "minifies all css", :hide => true
  def css_compress
    puts "minifying css"
    system "java -jar #{LIBS_DIR}yuicompressor-2.4.7.jar --type css #{BUILD_DIR}/css/main.css -o #{BUILD_DIR}/css/main.css "
  end

  desc "base", "Compiles all static assets"
  def base
    invoke :clean
    invoke :compass
    #invoke :less
    system "ppmtowinicon -output favicon.ico favicon.pnm"
  end

  desc "test", "builds and prepares site for a testing environment"
  def test
    invoke :base
    invoke :jekylldev
  end

  desc "prod", "minifies CSS and compresses html"
  def prod
    invoke :base
    invoke :bipartite
    invoke :jekyll
    invoke :css_compress
    invoke :javascript_compile
    invoke :version_static_content
    invoke :add_base_path
    invoke :html_compress
  end

  desc "deploy", "Pushes the site out to webserver and clears caches"
  def deploy
    invoke :prod
    system "rsync -azq _site/* gen2.csh.rit.edu:/tmp/stage"
    system "ssh -C ryansb.com 'sudo sb-com'"
  end

end
