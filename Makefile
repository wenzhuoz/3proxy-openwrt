include $(TOPDIR)/rules.mk

PKG_NAME:=3proxy
PKG_VERSION=0.8.13

PKG_MAINTAINER:=muziling <lls924@gmail.com>
PKG_LICENSE:=GPLv2
PKG_LICENSE_FILES:=LICENSE

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/z3APA3A/3proxy.git
PKG_SOURCE_VERSION:=e85b064b52296502a1dab648988a56e510088b76

PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE:=$(PKG_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_SOURCE_SUBDIR)

include $(INCLUDE_DIR)/package.mk

define Package/3proxy
	SUBMENU:=Web Servers/Proxies
	SECTION:=net
	CATEGORY:=Network
	TITLE:=3proxy for OpenWRT
	DEPENDS:=+libpthread +libopenssl
endef

define Package/3proxy/description
	3APA3A 3proxy tiny proxy server
endef

define Build/Configure
	$(CP) $(PKG_BUILD_DIR)/Makefile.Linux $(PKG_BUILD_DIR)/Makefile
endef

define Package/3proxy/conffiles
/etc/3proxy.cfg
endef

define Package/3proxy/install
	$(INSTALL_DIR) $(1)/usr/bin $(1)/etc/init.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/{3proxy,dighosts,ftppr,mycrypt,pop3p,proxy,socks,tcppm,udppm} $(1)/usr/bin
	$(INSTALL_BIN) ./files/3proxy.init $(1)/etc/init.d/3proxy
	$(INSTALL_CONF) ./files/3proxy.cfg $(1)/etc/
endef

$(eval $(call BuildPackage,3proxy))

