FROM open-liberty:full-java11-openj9

# Set the working directory
WORKDIR /app

# Copy the Liberty server configuration files and application files
COPY --chown=1001:0 server.xml /config/
COPY --chown=1001:0 <path_to_application_file>.war /config/dropins/ #change path

# Configure the Liberty server
RUN configure.sh

# Set environment variables for Elastic APM
ENV ELASTIC_APM_SERVICE_NAME=my-service #need to change
ENV ELASTIC_APM_SERVER_URL=http://apm-server:8200 #need to change 
ENV ELASTIC_APM_ENVIRONMENT=development

# Add the Elastic APM agent to the server
RUN installUtility install --acceptLicense default-features elastic-apm-agent

# Expose the default HTTP port
EXPOSE 9080

# Start the Liberty server
CMD ["/opt/ibm/wlp/bin/server", "run"]
