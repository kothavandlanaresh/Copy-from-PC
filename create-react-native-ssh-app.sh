#!/bin/bash

# Name of the React Native project
APP_NAME="RemoteFileCopyApp"

# Colors for output
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Function to check if a command exists
command_exists () {
    type "$1" &> /dev/null ;
}

# Install Node.js if not installed
install_node () {
    if ! command_exists node; then
        echo -e "${GREEN}Installing Node.js...${NC}"
        curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
        sudo apt-get install -y nodejs
    else
        echo -e "${GREEN}Node.js is already installed.${NC}"
    fi
}

# Install React Native CLI if not installed
install_react_native_cli () {
    if ! command_exists npx; then
        echo -e "${GREEN}Installing React Native CLI...${NC}"
        npm install -g react-native-cli
    else
        echo -e "${GREEN}React Native CLI is already installed.${NC}"
    fi
}

# Create a new React Native app
create_react_native_project () {
    if [ ! -d "$APP_NAME" ]; then
        echo -e "${GREEN}Creating a new React Native project: ${APP_NAME}${NC}"
        npx react-native init $APP_NAME
    else
        echo -e "${GREEN}React Native project ${APP_NAME} already exists.${NC}"
    fi
}

# Install required packages
install_packages () {
    cd $APP_NAME

    echo -e "${GREEN}Installing React Navigation...${NC}"
    npm install @react-navigation/native
    npm install @react-navigation/stack
    npm install react-native-screens react-native-safe-area-context

    echo -e "${GREEN}Installing React Native SSH SFTP...${NC}"
    npm install react-native-ssh-sftp

    echo -e "${GREEN}Linking native dependencies...${NC}"
    npx react-native link react-native-screens react-native-safe-area-context

    cd ..
}

# Launch the app on Android emulator or connected device
run_android_app () {
    cd $APP_NAME

    echo -e "${GREEN}Building and launching the React Native app...${NC}"
    npx react-native run-android

    cd ..
}

# Main script execution
echo -e "${GREEN}Starting React Native SSH App Setup...${NC}"

# Step 1: Install dependencies
install_node
install_react_native_cli

# Step 2: Create React Native project
create_react_native_project

# Step 3: Install necessary packages
install_packages

# Step 4: Run the app on Android (you can modify for iOS if necessary)
run_android_app

echo -e "${GREEN}App setup and launch complete!${NC}"
