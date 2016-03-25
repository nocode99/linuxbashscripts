#! /bin/bash

DOMAIN="https://releases.hashicorp.com/terraform/"
LATEST_VERSION="$(curl -s $DOMAIN | sed -n "/<ul>/,/<\/ul>/p" | \
    grep terraform | head -n 1 | awk -F"[/]" 'NF>2{print $3}')"
IS_UNZIP_INSTALLED="$(which unzip)"
IS_TF_INSTALLED="$(which terraform)"
CURRENT_USER=$USER

install_terraform() {
    echo "Downloading terraform... This may take a few minutes\n"
    curl -o ~/terraform_"$LATEST_VERSION".zip \
        "$DOMAIN$LATEST_VERSION"/terraform_"$LATEST_VERSION"_linux_386.zip
    if [ -f $IS_UNZIP_INSTALLED ]; then
        sudo unzip -o ~/terraform_"$LATEST_VERSION".zip -d "$1"
        sudo chown "$CURRENT_USER":"$CURRENT_USER" "$1"/terraform*
    else
        sudo apt-get install -y unzip
        sudo unzip -o ~/terraform_"$LATEST_VERSION".zip -d "$1"
        sudo chown "$CURRENT_USER":"$CURRENT_USER" "$1"/terraform*
    fi
}

################################################################################
# MAIN
################################################################################

# Is terraform installed?
if [ -f $IS_TF_INSTALLED ]; then
    INSTALLED_VERSION="$(terraform --version | head -n 1 | \
                      awk '{print $2}' | cut -c 2-)"
    # Is latest version installed?
    if [ "$LATEST_VERSION" == "$INSTALLED_VERSION" ]; then
        echo "Latest version of Terraform is installed. Exiting"
    # Update terraform
    else
        INSTALL_DIR="$( echo "$IS_TF_INSTALLED" | cut -d'/' -f 1-4 )"
        echo "New version of terraform is available.  Downloading and installing..."
        install_terraform "$INSTALL_DIR"
    fi
# Install terraform
else
    INSTALL_DIR="/usr/local/bin"
    install_terraform $INSTALL_DIR
fi

