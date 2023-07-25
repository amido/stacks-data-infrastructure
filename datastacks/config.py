from datetime import date
from typing import List, Optional

from pydantic import BaseModel, Field


class Common(BaseModel):
    dataset_name: str = Field(description="Dataset name, used to derive pipeline and linked service names.")
    pipeline_description: str = Field(description="Description of the pipeline to be created.")
    data_source_type: str = Field(description="Datasource type eg. azure_sql.")
    
    key_vault_linked_service_name: str = Field(description="Name of the keyvault service to connect to.")
    data_source_password_key_vault_secret_name: str = Field(description="Secret name of the data source password.")

    ado_variable_groups_nonprod: List[str] = Field(description="List of required variable groups in non production environment.")
    ado_variable_groups_prod: List[str] = Field(description="List of required variable groups in production environment.")

    default_arm_deployment_mode: Optional[str] = Field(description="Deployment mode for terraform; if not set, the default is Incremental")

    window_start_default: Optional[date] = Field(description="Date to set as start of default time window. Defaults to 2020-01-01")
    window_end_default: Optional[date] = Field(description="Date to set as end of default time window. Defaults to 2020-01-31")


class IngestConfig(BaseModel):
    common: Common
    bronze_container: str = Field(description="Name of container for Bronze data")


class SilverConfig(BaseModel):
    common: Common
    bronze_container: str = Field(description="Name of container for Bronze data")
    silver_container: Optional[str] = Field(description="Name of container for Silver data")


class GoldConfig(BaseModel):
    common: Common
    silver_container: Optional[str] = Field(description="Name of container for Silver data")
    gold_container: Optional[str] = Field(description="Name of container for Gold data")