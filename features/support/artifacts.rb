require 'aws/s3'

module Artifacts
  AWS_PARAMETERS = %w(ACCESS_KEY_ID AWS_S3_BUCKET SECRET_ACCESS_KEY)

  include AWS::S3

  def archive_artifacts
    if AWS_PARAMETERS.all? { |p| ENV[p] }
      puts "Establishing connection to S3"
      establish_s3_connection!

      if browserid_log && File.exists?(browserid_log)
        puts "Copying #{browserid_log} to S3"
        archive_log
        puts "OK"
      end

      if capture_dir && File.directory?(capture_dir)
        puts "Archiving screen captures"
        archive_captures
        puts "OK"
      end
    end
  end

  def establish_s3_connection!
    AWS::S3::Base.establish_connection!(
      :access_key_id => ENV['ACCESS_KEY_ID'],
      :secret_access_key => ENV['SECRET_ACCESS_KEY']
    )
  end

  def archive_log
    S3Object.store("browserid-#{build_tag}.log", open(browserid_log), artifact_bucket)
  end

  def archive_captures
    archive = "#{capture_dir}/captures.tar.gz"
    `tar czf #{archive} #{capture_dir}/*.png`
    S3Object.store("captures-#{build_tag}.tar.gz", open(archive), artifact_bucket)
  end

  def browserid_log
    ENV['BROWSERID_LOG']
  end

  def capture_dir
    ENV['CAPTURE_DIR']
  end

  def artifact_bucket
    ENV['AWS_S3_BUCKET']
  end

  def build_tag
    "#{Time.now.to_i}-#{ENV['DRIVER']}-#{RUBY_ENGINE}"
  end
end
