import logging

from pyspark.sql import SparkSession

from pysparkle.config import CONFIG_CONTAINER
from pysparkle.data_quality.config import Config
from pysparkle.data_quality.utils import (
    add_expectation_suite,
    create_datasource_context,
    execute_validations,
)
from pysparkle.storage_utils import check_env, load_json_from_blob, set_spark_properties
from pysparkle.utils import substitute_env_vars

logger = logging.getLogger(__name__)


def data_quality_main(config_path):
    check_env()

    dq_conf_dict = load_json_from_blob(CONFIG_CONTAINER, config_path)
    dq_conf = Config.parse_obj(dq_conf_dict)
    logger.info(f"Running Data Quality processing for dataset: {dq_conf.dataset_name}...")

    spark = SparkSession.builder.appName(f"DataQuality-{dq_conf.dataset_name}").getOrCreate()

    set_spark_properties(spark)

    for datasource in dq_conf.datasource_config:
        logger.info(f"Checking DQ for datasource: {datasource.datasource_name}...")

        source_type = getattr(spark.read, datasource.datasource_type)
        data_location = substitute_env_vars(datasource.data_location)
        df = source_type(data_location)

        gx_context = create_datasource_context(
            datasource.datasource_name, dq_conf.gx_directory_path
        )

        gx_context = add_expectation_suite(gx_context, datasource)

        results = execute_validations(gx_context, datasource, df)

        logger.info(f"DQ check completed for {datasource.datasource_name}. Results:")
        logger.info(results)

    logger.info("Finished: Data Quality processing.")