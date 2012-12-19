# KnowledgeCity #
How can we qualify/quantify the area of expertise of a software
developer working on one of CFMU's (oooopppss DNM's) systems?
Can we use the records from Remedy, i.e. the SCs and relevant items
linked to them?

### <a id="caveat"></a>CAVEAT ###
It is true that software is more often read than written [1],
and as such the numbers out of a KnowledgeCity-like analysis should be
complementary to any other source of information, i.e. feedback from
team leader/co-workers.

[1] Bracha, Gilad and Griswold, David
    "Strongtalk: typechecking Smalltalk in a production environment",
    http://doi.acm.org/10.1145/165854.165893

## <a id=""></a>DONE <a id="Done">##
* tried to describe the idea here
* [(draft) unix scripts][5] to extract the data

## <a id=""></a>TODO <a id="ToDo">##
1. assess the idea
2. gather data and prototype for 1 user with spreadsheet with coarse
and fine granularity:
Generate a csv file with Change Id, Originator, Responsible, System,
CR Reference, I2 Reference, Topic, Item System, Item Subsystem, Path,
File Name


3. If a 3D view is to be used it is necessary to understand what is mapped to what.
    width  = ?
    height = ?
    color  = ?
    relative position (two variables here) = ?
4. address Ada and C++ clustering of filenames
5. some histogram


## Introduction ##
This is an experimental area dedicated to explore the prototype of
**KnowledgeCity**.

The idea is to try to complement TLs input on team members' skills and
area of expertise with 'data from the field'.
The inspiration comes from [CodeCity][].

If you think about our closure graph, i.e. [TACT closure][1],
you can think of each closure component as a city block.
Certain CFMU systems are easier to cluster into (city-like) blocks,
for example Java software with its package oriented file organization
can be naturally organized. The case of Ada or C++ sources is more
difficult and clustering for them will probably need the use of some
AI techniques: k-means, expectation maximization.

[TACT closure graph][1] was generated on Linux by

    $ Cgraph -b TACT.TACT\_CONFIG.LATEST -o TACT_closure.gif

## Tech details <a id="Tech">##
Typically we save code changes tagged with SC (Software change) and
since some time (ca. 2000) we load the mane of the impacted
version-controlled entities in Remedy.

This allows us to produce a release note in semi-automated mode
where we can extract all CRs/SCs/I2s/PADs between 2 selected system
family baseline builds.

The same data could be used to extract where somebody has worked and
have an automated way to assess in which heads the knowledge resides:
this is not perfect science but could be instructive to see if it
somewhat confirms what TLs report.
It can also be useful to

 * investigate whether there are uncovered areas (and it could
   well be that they are untouched bacause stable...or dead)

 * see what area of code will be left uncovered if somebody leaves

 * ...

## Remedy Queries <a id='RemedyQueries'>##
The following are representative Remedy queries that can be used from
Advanced (Manual) Search box:

 * One of [all SCs in 2011 for BYG][2] is for example SC\_056402)

         (('Date & Time' >= "01/01/2011 00:00:00") AND ('Date & Time' <=
         "01/02/2012 00:00:00")) AND ('Originator' = "BYG" OR 'Responsible' = "BYG")

 * for SC\_056402 above, [the list of version controlled entities][3],
   a.k.a. files, impacted comes from the following Remedy query

         'SC ID' = "SC_056402"  AND 'File Name' != $NULL$
   One of them is for example [this][4].

## The (draft) idea <a id="Idea">##
In principle the data can be extracted: we have all SC worked by `<who>`
and associated to baseline build items, so that a per person histogram
can be produced for all files belonging to which component in the
various CFMU systems.
For the example data in [Tact closure][1], [list of SCs][2],
[items for SC][3] and [baseline item details][4] we could count
how many times file `an1_receiver_task-direct_control.adb`
in component `CORE` of system `TACT` has been 'touched' by `BYG` in
`2011`.

* For fine-grained classification:
  It is true that inside CORE you have clear clusters of files with
  related functionality which have the same prefix, for example
    atfm\_message\_...
    all\_ft...
    casa...
    casa\_task...
    ccams-client...
    ccams\_contingency...
  and this is just special of TACT; CHMI or CUA have probably different ways to
  organise the code either structurally (directories for the package name in Java)
  or by logically by name-prefix.

* for coarse granularity we could restrict the view to TACT/CORE


[1]:  TACT_closure.gif
      "a closure graph, i.e. latest TACT"
[2]: SoftwareChangeList.jpg
     "a list of  SCs"
[3]: BaselineItemList.jpg
     "baseline items list for an SC"
[4]: https://raw.github.com/espinielli/knowledgecity/master/BaselineItem.jpg
     "a baseline item"
[5]: scripts.html
     "knowledgecity scripts"
[CodeCity]:  http://www.inf.usi.ch/phd/wettel/codecity.html
             "CodeCity Home Page"
