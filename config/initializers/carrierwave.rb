CarrierWave.configure do |config|
  # Use local file storage so uploads and downloads stay on the existing server.
  config.storage = :file
  config.root = File.join(Rails.root, 'public')
  config.cache_dir = File.join(Rails.root, 'tmp', 'uploads')

  # AWS/S3 configuration kept for reference and disabled.
  # config.storage = :aws
  #
  # if Rails.env.development?
  #   config.aws_bucket = 'foursight-images-development'
  #   config.asset_host = 'https://zmsad.preview.prostack.host'
  # elsif Rails.env.production?
  #   config.asset_host = 'https://cdn.4sightplus.co.uk'
  #   config.aws_bucket = 'foursight-images-production'
  # end
  #
  # config.aws_acl = 'private'
  #
  # # Optionally define an asset host for configurations that are fronted by a
  # # content host, such as CloudFront.
  # # config.asset_host = 'https://cdn.myplaylifeapp.com'
  #
  # # The maximum period for authenticated_urls is only 7 days. Limited to 5 mins
  # config.aws_authenticated_url_expiration = 60 * 5
  #
  # # Set custom options such as cache control to leverage browser caching
  # config.aws_attributes = {
  #   expires: 1.week.from_now.httpdate,
  #   cache_control: 'max-age=604800'
  # }
  #
  # config.aws_credentials = {
  #   access_key_id:     'AKIAJCY2NB6EJAUNWESA',
  #   secret_access_key: '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',
  #   region:            'eu-west-1'
  # }
  #
  # if Rails.env.production?
  #   config.cache_dir = "/carrierwavefiles/uploads"
  # end
  #
  # config.aws_signer = -> (unsigned_url, options) do
  #   Aws::CF::Signer.sign_url(unsigned_url, options)
  # end
end
