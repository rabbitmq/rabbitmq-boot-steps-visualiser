%% This Source Code Form is subject to the terms of the Mozilla Public
%% License, v. 2.0. If a copy of the MPL was not distributed with this
%% file, You can obtain one at https://mozilla.org/MPL/2.0/.
%%
%% Copyright (c) 2011-2020 VMware, Inc. or its affiliates.  All rights reserved.

-module(rabbit_boot_steps_visualiser_wm).

-export([init/2, to_json/2, content_types_provided/2, is_authorized/2]).

-import(rabbit_misc, [pget/2]).

-include_lib("rabbitmq_management_agent/include/rabbit_mgmt_records.hrl").

%%--------------------------------------------------------------------
init(Req, _State) ->
    {cowboy_rest, rabbit_mgmt_cors:set_headers(Req, ?MODULE), #context{}}.


content_types_provided(ReqData, Context) ->
    {[{<<"application/json">>, to_json}], ReqData, Context}.

to_json(ReqData, Context) ->
    Steps = rabbit_boot_steps_visualiser_utils:boot_steps_as_dot(),
    Bin = iolist_to_binary(io_lib:format("~s", [Steps])),
    rabbit_mgmt_util:reply(Bin, ReqData, Context).

is_authorized(ReqData, Context) ->
    rabbit_mgmt_util:is_authorized(ReqData, Context).
