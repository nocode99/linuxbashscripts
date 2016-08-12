#! /bin/bash

DOMAIN="https://releases.hashicorp.com/terraform/"
LATEST_VERSION="$(curl -s $DOMAIN | sed -n "/<ul>/,/<\/ul>/p" | \
    grep terraform | head -n 1 | awk -F"[/]" 'NF>2{print $3}')"
IS_UNZIP_INSTALLED="$(which unzip 2>/dev/null)"
IS_TF_INSTALLED="$(which terraform 2>/dev/null)"
CURRENT_USER=$USER

install_terraform() {
    if [ ! -f ~/terraform_"$LATEST_VERSION".zip ] ; then
        echo "Downloading terraform... This may take a few minutes\n"
        curl -o ~/terraform_"$LATEST_VERSION".zip \
        "$DOMAIN$LATEST_VERSION"/terraform_"$LATEST_VERSION"_linux_386.zip
    fi
    echo "latest version already downloaded..."
    echo "unzipping and copying binary to $1"
    if [ -f $IS_UNZIP_INSTALLED ]; then
        sudo unzip -o ~/terraform_"$LATEST_VERSION".zip -d $1 >/dev/null
    else
        sudo apt-get install -y unzip
        sudo unzip -o ~/terraform_"$LATEST_VERSION".zip -d $1 >/dev/null
    fi
    if [ -e "$IS_TF_INSTALLED" ] ; then
        echo "Latest version of Terraform successfully installed"
    else
        echo "Uh oh, problem with installation."
    fi
}

################################################################################
# MAIN
################################################################################

# Is terraform installed?
if [ -e "$IS_TF_INSTALLED" ] ; then
    INSTALLED_VERSION="$(terraform --version | head -n 1 | \
                      awk '{print $2}' | cut -c 2- 2>/dev/null)"
    # Is latest version installed?
    if [ $LATEST_VERSION == $INSTALLED_VERSION ]; then
        echo "Latest version of Terraform is installed. Exiting"
    # Update terraform
    else
        INSTALL_DIR="$( echo "$IS_TF_INSTALLED" | cut -d'/' -f 1-4 )"
        echo "New version of terraform is available.  Downloading and installing..."
        install_terraform $INSTALL_DIR
    fi
# Install terraform
else
    INSTALL_DIR="/usr/local/bin"
    install_terraform $INSTALL_DIR
fi

