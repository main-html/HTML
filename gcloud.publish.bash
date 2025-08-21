# GNU General Public License v3.0
# Main HTML is an accessibility aware template putting users and web developers first, Copyright (C) 2025 Andy Futcher. See <https://mainhtml.dev/> for more
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.
## Main.HTML not modified from original. Date: 2025-08-01

# Feferences: https://cloud.google.com/sdk/gcloud/reference/storage/cp
# Load Configuration
publish_config="gcloud.config.bash";
source "$publish_config"; # Load from config file

# Check Variables Defined
if [[ -z "$content_language" || -z "$gsutil_uri" ]]; then echo "Error missing destination; please configure 'gcloud.config.bash' file first before proceeding..." >&2; exit 1; fi;

# Check Connection Status
gcloud storage cp --recursive *.txt $gsutil_uri/ --gzip-local-all --content-encoding "gzip" --content-type "text/plain; charset=utf-8" --content-language "$content_language" --cache-control "public, max-age=604800"; 
if [ $? -eq 0 ]; then echo "Authentication Success!"; else echo "Failed! Authentication..."; gcloud auth login --browser; exit 1; fi; # Exit if Failed!

# Upload Sitemaps & Feeds
find . -type f -name "*.xml" -newer "$publish_config" -exec file --mime-type {} + | sed 's/^\.\///' | grep 'text/xml' | awk -F': ' '{print $1}' | xargs -I {} gcloud storage cp "{}" $gsutil_uri/{} --gzip-local-all --content-encoding "gzip" --content-type "text/xml; charset=utf-8" --content-language "$content_language" --cache-control "public, max-age=86400"

# Upload Media
find . -type f -name "*.ico" -newer "$publish_config" -exec file --mime-type {} + | sed 's/^\.\///' | grep 'image/vnd.microsoft.icon' | awk -F': ' '{print $1}' | xargs -I {} gcloud storage cp "{}" $gsutil_uri/{} --gzip-local-all --content-encoding "gzip" --content-type "image/x-icon" --cache-control "public, max-age=31536000"
find . -type f -name "*.svg" -newer "$publish_config" -exec file --mime-type {} + | sed 's/^\.\///' | grep 'image/svg+xml' | awk -F': ' '{print $1}' | xargs -I {} gcloud storage cp "{}" $gsutil_uri/{} --gzip-local-all --content-encoding "gzip" --content-type "image/svg+xml; charset=utf-8" --content-language "$content_language" --cache-control "public, max-age=31536000"
find . -type f -name "*.avif" -newer "$publish_config" -exec file --mime-type {} + | sed 's/^\.\///' | grep 'image/avif' | awk -F': ' '{print $1}' | xargs -I {} gcloud storage cp "{}" $gsutil_uri/{} --content-type "image/avif" --content-language "$content_language" --cache-control "public, max-age=31536000"
find . -type f -name "*.webp" -newer "$publish_config" -exec file --mime-type {} + | sed 's/^\.\///' | grep 'image/webp' | awk -F': ' '{print $1}' | xargs -I {} gcloud storage cp "{}" $gsutil_uri/{} --content-type "image/webp" --content-language "$content_language" --cache-control "public, max-age=31536000"
find . -type f -name "*.jpg" -newer "$publish_config" -exec file --mime-type {} + | sed 's/^\.\///' | grep 'image/jpeg' | awk -F': ' '{print $1}' | xargs -I {} gcloud storage cp "{}" $gsutil_uri/{} --content-type "image/jpeg" --content-language "$content_language" --cache-control "public, max-age=31536000"
find . -type f -name "*.jpeg" -newer "$publish_config" -exec file --mime-type {} + | sed 's/^\.\///' | grep 'image/jpeg' | awk -F': ' '{print $1}' | xargs -I {} gcloud storage cp "{}" $gsutil_uri/{} --content-type "image/jpeg" --content-language "$content_language" --cache-control "public, max-age=31536000"
find . -type f -name "*.png" -newer "$publish_config" -exec file --mime-type {} + | sed 's/^\.\///' | grep 'image/png' | awk -F': ' '{print $1}' | xargs -I {} gcloud storage cp "{}" $gsutil_uri/{} --content-type "image/png" --content-language "$content_language" --cache-control "public, max-age=31536000"
find . -type f -name "*.mp4" -newer "$publish_config" -exec file --mime-type {} + | sed 's/^\.\///' | grep 'video/mp4' | awk -F': ' '{print $1}' | xargs -I {} gcloud storage cp "{}" $gsutil_uri/{} --content-type "video/mp4" --content-language "$content_language" --cache-control "public, max-age=31536000"
find . -type f -name "*.ogg" -newer "$publish_config" -exec file --mime-type {} + | sed 's/^\.\///' | grep 'audio/ogg' | awk -F': ' '{print $1}' | xargs -I {} gcloud storage cp "{}" $gsutil_uri/{} --content-type "audio/ogg" --content-language "$content_language" --cache-control "public, max-age=31536000"

# Upload HTML Pages
find . -type f -name "*.js" -newer "$publish_config" -exec file --mime-type {} + | sed 's/^\.\///' | grep 'text/html' | awk -F': ' '{print $1}' | xargs -I {} gcloud storage cp "{}" $gsutil_uri/{} --gzip-local-all --content-encoding "gzip" --content-type "text/javascript; charset=utf-8" --content-language "$content_language" --cache-control "public, max-age=31536000"
find . -type f -name "*.css" -newer "$publish_config" -exec file --mime-type {} + | sed 's/^\.\///' | grep 'text/plain' | awk -F': ' '{print $1}' | xargs -I {} gcloud storage cp "{}" $gsutil_uri/{} --gzip-local-all --content-encoding "gzip" --content-type "text/css; charset=utf-8" --content-language "$content_language" --cache-control "public, max-age=31536000"
find . -type f -name "*.htm*" -newer "$publish_config" -exec file --mime-type {} + | sed 's/^\.\///' | grep 'text/html' | awk -F': ' '{print $1}' | xargs -I {} gcloud storage cp "{}" $gsutil_uri/{} --gzip-local-all --content-encoding "gzip" --content-type "text/html; charset=utf-8" --content-language "$content_language" --cache-control "public, max-age=86400"

# Mark Completed (update timestamp)
touch "$publish_config";
echo "Publishing Successful!";
