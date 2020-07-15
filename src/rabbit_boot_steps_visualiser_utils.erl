%% This Source Code Form is subject to the terms of the Mozilla Public
%% License, v. 2.0. If a copy of the MPL was not distributed with this
%% file, You can obtain one at https://mozilla.org/MPL/2.0/.
%%
%% Copyright (c) 2011-2020 VMware, Inc. or its affiliates.  All rights reserved.

-module(rabbit_boot_steps_visualiser_utils).

-export([boot_steps_as_dot/0]).

boot_steps_as_dot() ->
    Header = ["digraph BootSteps {"],
    Attribs = ["node [fontname = monospace];"],
    Tail = ["}"],
    Steps = rabbit_boot_steps:find_steps(),
    Res =
        lists:foldl(
          fun ({_App, StepName, Step}, Acc) ->
                  Reqs = process_requires(StepName,
                                          proplists:get_value(requires, Step)),
                  Ens = process_enables(StepName,
                                        proplists:get_value(enables, Step)),
                  [Reqs, Ens | Acc]
          end, [], Steps),
    [lists:concat(Header ++ Attribs ++ Res ++ Tail)].

process_enables(_StepName, undefined) ->
    [];
process_enables(StepName, Enables) when is_atom(Enables) ->
    [atom_to_list(StepName), "->", atom_to_list(Enables), ";"];
process_enables(StepName, Enables) when is_list(Enables) ->
    lists:concat([process_requires(StepName, En) || En <- Enables]).

process_requires(_StepName, undefined) ->
    [];
process_requires(StepName, Requires) when is_atom(Requires) ->
    [atom_to_list(Requires), "->", atom_to_list(StepName), ";"];
process_requires(StepName, Requires) when is_list(Requires) ->
    lists:concat([process_requires(StepName, Req) || Req <- Requires]).
