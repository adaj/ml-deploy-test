FROM python:3.10

WORKDIR /ml-deploy-test

# Copy requirements first to leverage Docker cache. 
# This assumes streamlit and its dependencies (requests, pandas, plotly) are in the root requirements.txt
RUN pip install --no-cache-dir streamlit requests pandas plotly

# Copy the specific application files needed for the Streamlit app
# The `app/` directory from the build context (project root) is copied into 
# `/ml-deploy-test/app/` inside the container.
COPY app/ app/

# Expose the port Streamlit runs on (default is 8501)
EXPOSE 8501

# Command to run the Streamlit application
# The path app/streamlit.py is relative to the WORKDIR /ml-deploy-test
# So it will execute /ml-deploy-test/app/streamlit.py
CMD ["streamlit", "run", "app/streamlit.py", "--server.port=8501", "--server.headless=true"] 
