# Article

## Issues and Solutions
- Issue right now is that, while I am creating the proper CoreData objects, I am not RETRIEVING them properly. Right now, I am using an NSPredicate which is not working and I beleive I know why. 
    - The most straightforward/simple solution is to utilize the UUID's I have in CoreData for the different entities. Basically, that means that instead of working with Date objects through the different views, I instead work with a struct that houses the DateDatum entity - and thus has a id, name, and tasks field. 
    
## To Do
    - [] Create a struct to mirror DateDatum entity
    - [] Change both views so that they work with the new struct 
    - [] Create function in ChecklistViewModel that grabs TaskDatum and DateDatum via UUID
    - [] Update functions in ChecklistViewModel so that dependent functions grab TaskDatum and DateDatum via UUID
    

## Overview

Create a daily checklist 

## Topics

