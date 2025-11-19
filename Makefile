PROJECT = rabbitmq_boot_steps_visualiser
PROJECT_DESCRIPTION = RabbitMQ Boot Steps Visualiser

DEPS = rabbit_common rabbit rabbitmq_management

DEP_EARLY_PLUGINS = rabbit_common/mk/rabbitmq-early-plugin.mk
DEP_PLUGINS = rabbit_common/mk/rabbitmq-plugin.mk

include ../../rabbitmq-components.mk
include ../../erlang.mk
