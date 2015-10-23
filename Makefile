export ARCHS = armv7 armv7s arm64
export TARGET = iphone:clang:9.0:7.0

include theos/makefiles/common.mk

TWEAK_NAME = Lithium
Lithium_FILES = Tweak.xm
Lithium_FRAMEWORKS = UIKit CoreGraphics
Lithium_LIBRARIES += objcipc
Lithium_LDFLAGS += -Wl,-segalign,4000

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += LithiumPreferences LithiumServer
include $(THEOS_MAKE_PATH)/aggregate.mk

before-stage::
	find . -name ".DS_Store" -delete
internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/Lithium$(ECHO_END)
	$(ECHO_NOTHING)cp Themes/Compiled/*.js $(THEOS_STAGING_DIR)/Library/Lithium$(ECHO_END)
