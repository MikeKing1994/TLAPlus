---- MODULE MC ----
EXTENDS LoadLevellingCache, TLC

\* INIT definition @modelBehaviorNoSpec:0
init_167615112099416000 ==
FALSE/\acct = 0
----
\* NEXT definition @modelBehaviorNoSpec:0
next_167615112099417000 ==
FALSE/\acct' = acct
----
=============================================================================
\* Modification History
\* Created Sat Feb 11 21:32:00 GMT 2023 by micha
