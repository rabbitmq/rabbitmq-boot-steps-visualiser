# RabbitMQ Boot Steps Visualiser #

This plugin adds an extension to RabbitMQ's Management Web GUI to
visualise the current boot steps graph.

Boot Steps are a declarative way to tell RabbitMQ which components to
start, and in which order. Since plugins can make use of boot steps,
sometimes it's hard to know how a RabbitMQ broker was started, what
boot steps were executed, and in which order. This plugins solves that
problem by presenting the boot steps as a graph.

More information on the boot steps system can be found here:
https://github.com/videlalvaro/rabbit-internals/blob/master/rabbit_boot_process.md

It looks like this:

![Web Interface](https://raw.githubusercontent.com/rabbitmq/rabbitmq-boot-steps-visualiser/master/docs/visualiser_screenshot.png)


# Installing #

At the moment you have to build it from source since it uses RabbitMQ
current master branch. For the next release of RabbitMQ the plugin
will be able to provide a binary release of the plugin.

Clone the `rabbitmq-umbrella`:

```bash
git clone https://github.com/rabbitmq/rabbitmq-public-umbrella.git
cd rabbitmq-public-umbrella
make co
```

Then clone the plugin's repo:

```bash
git clone https://github.com/rabbitmq/rabbitmq-boot-steps-visualiser.git
cd rabbitmq-boot-steps-visualiser
make
```

Copy the plugin's `.ez` file from the `./dist` folder into your
RabbitMQ plugin's folder; then you can enable the plugin.

# LICENSE #

See the LICENSE file.
