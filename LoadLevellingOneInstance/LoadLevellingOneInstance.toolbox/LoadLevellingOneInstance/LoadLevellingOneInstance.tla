---- MODULE LoadLevellingOneInstance ----
EXTENDS TLC, Integers

(* --algorithm LoadLevellingOneInstance
variables 
State = "Ready";
GsCalls = 0;
GsLimit = 5;
CacheCount = 0;
IterationLimit = 100;
ActionCount = 0;


define 
    BelowGsLimit == 
        GsCalls <= GsLimit
    
end define;

begin
    Iterate:
        while ActionCount <= 100 do
            if State = "Ready" then
                State := "ReadingCache";
                
            elsif State = "ReadingCache" /\ CacheCount < GsLimit then
                State := "WritingCache";
                
            elsif State = "ReadingCache" /\ CacheCount >= GsLimit then 
                State := "Ready";
                
            elsif State = "WritingCache" then 
                State := "CallingGs";
                CacheCount := CacheCount + 1;
                
            elsif State = "CallingGs" then
                State := "Ready";
                GsCalls := GsCalls + 1;
            else
                State := "Ready";
            end if;
            
            ActionCount := ActionCount + 1;
        end while;
        
            

end algorithm; *)
\* BEGIN TRANSLATION (chksum(pcal) = "800d2360" /\ chksum(tla) = "47e4d3e5")
VARIABLES State, GsCalls, GsLimit, CacheCount, IterationLimit, ActionCount, 
          pc

(* define statement *)
BelowGsLimit ==
    GsCalls <= GsLimit


vars == << State, GsCalls, GsLimit, CacheCount, IterationLimit, ActionCount, 
           pc >>

Init == (* Global variables *)
        /\ State = "Ready"
        /\ GsCalls = 0
        /\ GsLimit = 5
        /\ CacheCount = 0
        /\ IterationLimit = 100
        /\ ActionCount = 0
        /\ pc = "Iterate"

Iterate == /\ pc = "Iterate"
           /\ IF ActionCount <= 100
                 THEN /\ IF State = "Ready"
                            THEN /\ State' = "ReadingCache"
                                 /\ UNCHANGED << GsCalls, CacheCount >>
                            ELSE /\ IF State = "ReadingCache" /\ CacheCount < GsLimit
                                       THEN /\ State' = "WritingCache"
                                            /\ UNCHANGED << GsCalls, 
                                                            CacheCount >>
                                       ELSE /\ IF State = "ReadingCache" /\ CacheCount >= GsLimit
                                                  THEN /\ State' = "Ready"
                                                       /\ UNCHANGED << GsCalls, 
                                                                       CacheCount >>
                                                  ELSE /\ IF State = "WritingCache"
                                                             THEN /\ State' = "CallingGs"
                                                                  /\ CacheCount' = CacheCount + 1
                                                                  /\ UNCHANGED GsCalls
                                                             ELSE /\ IF State = "CallingGs"
                                                                        THEN /\ State' = "Ready"
                                                                             /\ GsCalls' = GsCalls + 1
                                                                        ELSE /\ State' = "Ready"
                                                                             /\ UNCHANGED GsCalls
                                                                  /\ UNCHANGED CacheCount
                      /\ ActionCount' = ActionCount + 1
                      /\ pc' = "Iterate"
                 ELSE /\ pc' = "Done"
                      /\ UNCHANGED << State, GsCalls, CacheCount, ActionCount >>
           /\ UNCHANGED << GsLimit, IterationLimit >>

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Iterate
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION 
====
