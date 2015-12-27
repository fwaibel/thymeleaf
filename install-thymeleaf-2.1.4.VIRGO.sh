export ARTIFACT_ID="thymeleaf"
export GROUP_ID="org.thymeleaf"
export VERSION="2.1.4.VIRGO"

mvn clean compile bundle:bundle
mvn install:install-file -Dfile=target/${ARTIFACT_ID}-${VERSION}.jar -DgroupId=${GROUP_ID} -DartifactId=${ARTIFACT_ID} -Dversion=${VERSION} -Dpackaging=jar
