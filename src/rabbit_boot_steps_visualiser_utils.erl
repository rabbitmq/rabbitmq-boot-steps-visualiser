%%   The contents of this file are subject to the Mozilla Public License
%%   Version 1.1 (the "License"); you may not use this file except in
%%   compliance with the License. You may obtain a copy of the License at
%%   http://www.mozilla.org/MPL/
%%
%%   Software distributed under the License is distributed on an "AS IS"
%%   basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
%%   License for the specific language governing rights and limitations
%%   under the License.
%%
%%   The Original Code is RabbitMQ Boot Steps Visualiser.
%%
%%   The Initial Developer of the Original Code is GoPivotal, Inc.
%%   Copyright (c) 2011-2015 GoPivotal, Inc.  All rights reserved.

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
