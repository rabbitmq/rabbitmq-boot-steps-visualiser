dispatcher_add(function(sammy) {
  sammy.get('#/boot_steps_visualiser', function() {
    render({'boot_steps_visualiser': {path:    '/boot_steps_visualiser',
                                      options: {}}},
    'boot_steps_visualiser', '#/boot_steps_visualiser');
  });
});

NAVIGATION['Boot Steps Visualiser'] = ['#/boot_steps_visualiser', "management"];
