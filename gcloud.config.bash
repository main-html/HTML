# GNU General Public License v3.0
# Main HTML is an accessibility aware template putting users and web developers first, Copyright (C) 2025 Andy Futcher. See <https://mainhtml.dev/> for more
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.
## Main.HTML not modified from original. Date: 2025-09-05 ###

# Main HTML Publishing Config

# Current Timestamp
iso_8601=$(date --iso-8601=seconds)

# Default Language from all bucket resources
# e.g. "en-US" an ISO 639-1 and optional ISO 3166-1 Alpha-2
content_language=""

# Google Cloud bucket gsutil URI path
# e.g. "gs://<bucket-name>" and optionally include path if requred
gsutil_uri=""

# Sitemap Homepage
# e.g. "https://yourdomain.com" with trailing slash
homepage_url=""
