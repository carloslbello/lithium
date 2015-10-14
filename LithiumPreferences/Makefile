export ARCHS = armv7 armv7s arm64
export TARGET = iphone:clang:9.0:7.0

include ../theos/makefiles/common.mk

BUNDLE_NAME = LithiumPreferences
LithiumPreferences_FILES = LithiumPreferences.m
LithiumPreferences_INSTALL_PATH = /Library/PreferenceBundles
LithiumPreferences_FRAMEWORKS = UIKit Foundation CoreGraphics
LithiumPreferences_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/LithiumPreferences.plist$(ECHO_END)
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceBundles/LithiumPreferences.bundle$(ECHO_END)
	$(ECHO_NOTHING)cp icon*.png LithiumPreferences.plist Info.plist $(THEOS_STAGING_DIR)/Library/PreferenceBundles/LithiumPreferences.bundle$(ECHO_END)
