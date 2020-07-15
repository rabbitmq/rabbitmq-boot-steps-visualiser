%% This Source Code Form is subject to the terms of the Mozilla Public
%% License, v. 2.0. If a copy of the MPL was not distributed with this
%% file, You can obtain one at https://mozilla.org/MPL/2.0/.
%%
%% Copyright (c) 2011-2020 VMware, Inc. or its affiliates.  All rights reserved.

-module(rabbit_boot_steps_visualiser_dispatch).

-behaviour(rabbit_mgmt_extension).

-export([dispatcher/0, web_ui/0]).

dispatcher() -> [{"/boot_steps_visualiser", rabbit_boot_steps_visualiser_wm, []}].

web_ui()     -> [{javascript, <<"boot_steps_visualiser.js">>}].
