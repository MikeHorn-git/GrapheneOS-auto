# https://grapheneos.org/releases
PKG := pacman
PKG_INSTALL_FLAGS = -S --needed --noconfirm
PKG_RM_FLAGS = -Rns --noconfirm
SU := sudo

SIGNERS_FILE = ./allowed_signers
SIGNERS_URL = https://releases.grapheneos.org/allowed_signers

.DEFAULT_GOAL := help
.ONESHELL

help:
	@echo "Usage: make <target>"
	@echo "Targets:"
	@echo "  help            Show this help message"
	@echo "  reqs            Install packages requirements for Arch"
	@echo "  images          Retreive and check factory images"
	@echo "  lock            Lock the bootloader"
	@echo "  unlock          Unlock the bootloader"
	@echo "  flash           Flash factory images"
	@echo "  clean           Remove factory images folders"
	@echo "  prune           Remove android-tools package"
	@echo "  distclean       Clean & Prune"

reqs:
	@$(SU) $(PKG) $(PKG_INSTALL_FLAGS) android-tools curl openssh

images:
ifneq ($(wildcard $(SIGNERS_FILE)),)
	@curl -O $(SIGNERS_URL)
endif
	@curl -O https://releases.grapheneos.org/$(DEVICE_NAME)-install-$(VERSION).zip
	@curl -O https://releases.grapheneos.org/$(DEVICE_NAME)-install-$(VERSION).zip.sig
	@ssh-keygen -Y verify -f allowed_signers -I contact@grapheneos.org -n "factory images" -s $(DEVICE_NAME)-install-$(VERSION).zip.sig < $(DEVICE_NAME)-install-$(VERSION).zip

lock:
	@fastboot flashing lock

unlock:
	@fastboot flashing unlock

flash:
	@bsdtar xvf $(DEVICE_NAME)-install-$(VERSION).zip
	cd $(DEVICE_NAME)-install-$(VERSION)
	bash flash-all.sh

clean:
	-@rm $(DEVICE_NAME)-install-$(VERSION)
	-@rm $(DEVICE_NAME)-install-$(VERSION).zip
	-@rm $(DEVICE_NAME)-install-$(VERSION).zip.sig
	-@rm allowed_signers

prune:
	@$(SU) $(PKG) $(PKG_RM_FLAGS) android-tools

distclean: clean prune

.PHONY: reqs images lock unlock flash clean prune distclean
