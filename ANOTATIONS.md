#STRUCTURE CLEAN ARCHITECTURE

 - lib -> core

  - features
    --> name_feature
        --> data - provide the data to the others layers.
            --> datasources - data layer(will get the data from the sources).
            --> models - model of the data
            --> repositories - implementations of repositories not the abstract.

        --> domain - layer that should not be susceptible to do changing datasources. (should be independent of anything inside the app). will contains the business logic inside the usecases.
            --> use cases - business logic of the feature.
            --> entities - class feature(more than one).
            --> repositories - contract of the abstract classes.

        --> presentation - where we will have all the UI, simple logics to handle and to transfer the data to the use cases on the domain.
            --> controllers - only simple logic to handle simple cases, then move all data to the use Cases in Domain
            --> pages - pages of the app
            --> widgets - widgets globally used in the many pages in the app.


#PACKAGES
  --> dartz - in that package we are allowed to use some functional programming stuff that simplify our process to get errors and handle they in the best way possible.