import os

AZURE_SUBSCRIPTION_ID = os.environ.get("AZURE_SUBSCRIPTION_ID")
AZURE_RESOURCE_GROUP_NAME = os.environ.get("AZURE_RESOURCE_GROUP_NAME")
AZURE_DATA_FACTORY_NAME = os.environ.get("AZURE_DATA_FACTORY_NAME")
AZURE_REGION_NAME = os.environ.get("AZURE_REGION_NAME")
AZURE_STORAGE_ACCOUNT_NAME = os.environ.get("AZURE_STORAGE_ACCOUNT_NAME")

RAW_CONTAINER_NAME = "raw"
ADLS_URL = f"https://{AZURE_STORAGE_ACCOUNT_NAME}.dfs.core.windows.net"
AUTOMATED_TEST_OUTPUT_DIRECTORY_PREFIX = "automated_test"
SQL_DB_INGEST_DIRECTORY_NAME = "example_azuresql_1"