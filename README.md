# To Do
- Done with app and currently using on my phone. 
- Add in Gifs on how it looks like


# Background & Notes

## Motivation
Wanted a daily todo list which helps me track the things to do every day. For example, drinking X liters of water, etc. 
I looked for an app like such at the app store but couldnt find one. Hence, I decided to make a quick version of my idea. 

## Basic Functionality
History
  - See the status (wheter you did them or not) of todo's for previous days 


## Notes
I made a prototype version of this idea in another repo. 
However, I didnt plan it out and alot of my implementation was clunky, disorganized and ineffecient (granted, I was doing it in the middle of exams 😅).
This implementation is much more efficient and clean, and I added proper swift documentation for the functions! 

## Issues and Solutions
- Issue right now is that, while I am creating the proper CoreData objects, I am not RETRIEVING them properly. Right now, I am using an NSPredicate which is not working and I beleive I know why. 
    - The most straightforward/simple solution is to utilize the UUID's I have in CoreData for the different entities. Basically, that means that instead of working with Date objects through the different views, I instead work with a struct that houses the DateDatum entity - and thus has a id, name, and tasks field. 
   
    


