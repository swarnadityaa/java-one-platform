# ARG SRE_DOCKER_REPO_PATH=us-central1-docker.pkg.dev/uni-4d736d0791c3532c02bed18e/uni-container-images
# ARG OPEN_JDK_VERSION=17-jdk-slim
 
# #Dynatrace Integration: https://github.uni.com/SRE/project-manager#knowledge-articles
 
# FROM ${SRE_DOCKER_REPO_PATH}/openjdk:${OPEN_JDK_VERSION}
ARG GOLDEN_IMAGE_REPO_PATH=registry.uni.com/golden
ARG GOLDEN_JAVA_21_VERSION=21
 
FROM ${GOLDEN_IMAGE_REPO_PATH}/java-dynatrace:${GOLDEN_JAVA_21_VERSION}
# RUN mkdir /app
COPY ./build/libs/*-build-*.jar /app/app.jar
 
ENV JAVA_OPTS="$JAVA_OPTS -Djava.security.egd=file:/dev/./urandom"
 
ENTRYPOINT ["java","-jar","/app/app.jar"]
EXPOSE 8080
