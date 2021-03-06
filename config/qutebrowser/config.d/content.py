# Automatically start playing `<video>` elements. Note: On Qt < 5.11,
# this option needs a restart and does not support URL patterns.
# Type: Bool
c.content.autoplay = False

# Size (in bytes) of the HTTP network cache. Null to use the default
# value. With QtWebEngine, the maximum supported value is 2147483647 (~2
# GB).
# Type: Int
c.content.cache.size = None

# Allow websites to read canvas elements. Note this is needed for some
# websites to work properly.
# Type: Bool
c.content.canvas_reading = True

# Which cookies to accept.
# Type: String
# Valid values:
#   - all: Accept all cookies.
#   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.
c.content.cookies.accept = "all"

# Store cookies. Note this option needs a restart with QtWebEngine on Qt
# < 5.9.
# Type: Bool
c.content.cookies.store = True

# Default encoding to use for websites. The encoding must be a string
# describing an encoding such as _utf-8_, _iso-8859-1_, etc.
# Type: String
c.content.default_encoding = "iso-8859-1"

# Allow websites to share screen content. On Qt < 5.10, a dialog box is
# always displayed, even if this is set to "true".
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
c.content.desktop_capture = "ask"

# Try to pre-fetch DNS entries to speed up browsing.
# Type: Bool
c.content.dns_prefetch = True

# Allow websites to request geolocations.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
c.content.geolocation = "ask"

# Allow websites to lock your mouse pointer.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
c.content.mouse_lock = "ask"

# Value to send in the `Accept-Language` header. Note that the value
# read from JavaScript is always the global value.
# Type: String
c.content.headers.accept_language = "en-US,en"

# Custom headers for qutebrowser HTTP requests.
# Type: Dict
c.content.headers.custom = {}

# Value to send in the `DNT` header. When this is set to true,
# qutebrowser asks websites to not track your identity. If set to null,
# the DNT header is not sent at all.
# Type: Bool
c.content.headers.do_not_track = True

# When to send the Referer header. The Referer header tells websites
# from which website you were coming from when visiting them. No restart
# is needed with QtWebKit.
# Type: String
# Valid values:
#   - always: Always send the Referer.
#   - never: Never send the Referer. This is not recommended, as some sites may break.
#   - same-domain: Only send the Referer for the same domain. This will still protect your privacy, but shouldn't break any sites. With QtWebEngine, the referer will still be sent for other domains, but with stripped path information.
c.content.headers.referer = "same-domain"

# User agent to send. Unset to send the default. Note that the value
# read from JavaScript is always the global value.
# Type: String
c.content.headers.user_agent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.87 Safari/537.36"

# Enable host blocking.
# Type: Bool
c.content.host_blocking.enabled = True

# List of URLs of lists which contain hosts to block.  The file can be
# in one of the following formats:  - An `/etc/hosts`-like file - One
# host per line - A zip-file of any of the above, with either only one
# file, or a file   named `hosts` (with any extension).  It's also
# possible to add a local file or directory via a `file://` URL. In case
# of a directory, all files in the directory are read as adblock lists.
# The file `~/.config/qutebrowser/blocked-hosts` is always read if it
# exists.
# Type: List of Url
c.content.host_blocking.lists = ['https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts']

# A list of patterns that should always be loaded, despite being ad-
# blocked. Note this whitelists blocked hosts, not first-party URLs. As
# an example, if `example.org` loads an ad from `ads.example.org`, the
# whitelisted host should be `ads.example.org`. If you want to disable
# the adblocker on a given page, use the `content.host_blocking.enabled`
# setting with a URL pattern instead. Local domains are always exempt
# from hostblocking.
# Type: List of UrlPattern
c.content.host_blocking.whitelist = []

# Enable hyperlink auditing (`<a ping>`).
# Type: Bool
c.content.hyperlink_auditing = False

# Load images automatically in web pages.
# Type: Bool
c.content.images = True

# Show javascript alerts.
# Type: Bool
c.content.javascript.alert = True

# Allow JavaScript to read from or write to the clipboard. With
# QtWebEngine, writing the clipboard as response to a user interaction
# is always allowed.
# Type: Bool
c.content.javascript.can_access_clipboard = True

# Allow JavaScript to open new tabs without user interaction.
# Type: Bool
c.content.javascript.can_open_tabs_automatically = True

# Enable JavaScript.
# Type: Bool
c.content.javascript.enabled = True

# Log levels to use for JavaScript console logging messages. When a
# JavaScript message with the level given in the dictionary key is
# logged, the corresponding dictionary value selects the qutebrowser
# logger to use. On QtWebKit, the "unknown" setting is always used.
# Type: Dict
c.content.javascript.log = {
    "error": "debug",
    "info": "debug",
    "unknown": "debug",
    "warning": "debug",
}

# Use the standard JavaScript modal dialog for `alert()` and
# `confirm()`.
# Type: Bool
c.content.javascript.modal_dialog = False

# Show javascript prompts.
# Type: Bool
c.content.javascript.prompt = True

# Allow locally loaded documents to access remote URLs.
# Type: Bool
c.content.local_content_can_access_remote_urls = False

# Allow locally loaded documents to access other local URLs.
# Type: Bool
c.content.local_content_can_access_file_urls = True

# Enable support for HTML 5 local storage and Web SQL.
# Type: Bool
c.content.local_storage = True

# Netrc-file for HTTP authentication. If unset, `~/.netrc` is used.
# Type: File
c.content.netrc_file = None

# Allow websites to show notifications.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
c.content.notifications = "ask"

# Allow pdf.js to view PDF files in the browser. Note that the files can
# still be downloaded by clicking the download button in the pdf.js
# viewer.
# Type: Bool
c.content.pdfjs = False

# Allow websites to request persistent storage quota via
# `navigator.webkitPersistentStorage.requestQuota`.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
c.content.persistent_storage = "ask"

# Enable plugins in Web pages.
# Type: Bool
c.content.plugins = False

# Draw the background color and images also when the page is printed.
# Type: Bool
c.content.print_element_backgrounds = True

# Open new windows in private browsing mode which does not record
# visited pages.
# Type: Bool
c.content.private_browsing = False

# Proxy to use. In addition to the listed values, you can use a
# `socks://...` or `http://...` URL.
# Type: Proxy
# Valid values:
#   - system: Use the system wide proxy.
#   - none: Don't use any proxy
c.content.proxy = "system"

# Allow websites to register protocol handlers via
# `navigator.registerProtocolHandler`.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
c.content.register_protocol_handler = "ask"

# Validate SSL handshakes.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
c.content.ssl_strict = "ask"

# List of user stylesheet filenames to use.
# Type: List of File, or File
c.content.user_stylesheets = []

# Enable WebGL.
# Type: Bool
c.content.webgl = True

# Which interfaces to expose via WebRTC. On Qt 5.10, this option doesn't
# work because of a Qt bug.
# Type: String
# Valid values:
#   - all-interfaces: WebRTC has the right to enumerate all interfaces and bind them to discover public interfaces.
#   - default-public-and-private-interfaces: WebRTC should only use the default route used by http. This also exposes the associated default private address. Default route is the route chosen by the OS on a multi-homed endpoint.
#   - default-public-interface-only: WebRTC should only use the default route used by http. This doesn't expose any local addresses.
#   - disable-non-proxied-udp: WebRTC should only use TCP to contact peers or servers unless the proxy server supports UDP. This doesn't expose any local addresses either.
c.content.webrtc_ip_handling_policy = "all-interfaces"

# Monitor load requests for cross-site scripting attempts. Suspicious
# scripts will be blocked and reported in the inspector's JavaScript
# console. Note that bypasses for the XSS auditor are widely known and
# it can be abused for cross-site info leaks in some scenarios, see:
# https://www.chromium.org/developers/design-documents/xss-auditor
# Type: Bool
c.content.xss_auditing = False

# Automatically mute tabs. Note that if the `:tab-mute` command is used,
# the mute status for the affected tab is now controlled manually, and
# this setting doesn't have any effect.
# Type: Bool
c.content.mute = False

