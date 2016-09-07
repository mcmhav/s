CWD=$(pwd);
TEMP_FOLDER="/d/Users/k00753/AppData/Local/Temp";

shutDownPrograms() {
    echo "Shutting down programs"
}
restartApplications() {
    echo "Restarting applications"
}

cleanTMP() {
    echo "Clearing $TEMP_FOLDER folder"
    cd TEMP_FOLDER;
    rm -rf "./*";
    cd CWD;
}

shutDownPrograms
cleanTMP
restartApplications
