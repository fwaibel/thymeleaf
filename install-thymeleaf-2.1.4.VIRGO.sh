export ARTIFACT_ID="thymeleaf"
export GROUP_ID="org.thymeleaf"
export VERSION="2.1.4.VIRGO"
export BUILD_TYPE=CI

USAGE_MESSAGE="Usage: $0 [-h] [-l]
 -h help
 -l local build"

while getopts hl args
do case "$args" in
  l) echo "switching to local build"
     BUILD_TYPE="LOCAL";;
  h) echo "${USAGE_MESSAGE}"
     exit 1;;
  :) echo "${USAGE_MESSAGE}"
     exit 1;;
  *) echo "${USAGE_MESSAGE}"
     exit 1;;
esac
done

shift $(($OPTIND - 1))

./mvnw clean compile bundle:bundle

if [ ${BUILD_TYPE} == "LOCAL" ]; then
  echo "local build detected..."
  ./mvnw install:install-file -Dfile=target/${ARTIFACT_ID}-${VERSION}.jar -DgroupId=${GROUP_ID} -DartifactId=${ARTIFACT_ID} -Dversion=${VERSION} -Dpackaging=jar
else
  echo "CI build detected..."
  ./mvnw install:install-file -Dfile=target/${ARTIFACT_ID}-${VERSION}.jar -DgroupId=${GROUP_ID} -DartifactId=${ARTIFACT_ID} -Dversion=${VERSION} -Dpackaging=jar -DlocalRepositoryPath=/var/maven/repository/
fi
