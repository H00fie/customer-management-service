# Customer Management Service
An ABAP application for managing customer information and perforimng various tasks related to customer management.

---
This application's purpose is to mimic an entire customer management system and utilize as many features, functions and possibilities of ABAP in the process as possible,
all the while keeping adhering to the Object Oriented Paradigm.

In order to check its possibilities, one needs to move the code into the SAP system (SE38 transaction) as follows:
- in SE38 transaction, a new application needs to be created and named CUSTOMER_MANAGEMENT_SERVICE.
- the code from the "main" file needs to be copied into the editor.
- every single one of the "includes" needs to be double clicked - SAP will attempt to thus create the files.
- the code from each of the files from the "include" directory needs to be placed in the appropriate INCLUDE within our program - "sel" within CUSTOMER_MANAGEMENT_SERVICE_SEL, "def" within CUSTOMER_MANAGEMENT_SERVICE_DEF and so forth. 
- in ABAP programs, the names of screen elements such as blocks, frames, parameters, radiobuttons or pushbuttons or usually stored outside of the source code. Due to the lack of possibility to include a SAP tool for storing these texts - they have been placed as comments within the "sel" include - as there are the elements to which they refer. In order for the program to process the names properly, one needs to select "Go to" option from the SAP GUI's menu, proceed to "Text elements" and place both the name of the element and its name there. "Symbol" column should contain the name of the element and "Text" column should contain what one wants to be displayed in the Selection Screen for the particular element.
- much like the names of the screen's elements, the messages displayed to the user of the program are stored outside of the source code - within the appropriate message class. Thus, here they are stored within a comment section in the "imp" include. In order to have the application read them correctly they need to be moved to their own message class. It is thus required to go to SE91 transaction, provide the name of the program in the input box and create the new message class. In the "Attributes" tab one is required to provide the short description of the message class. It is good practice to simply write it is a message class for <our program's name>. Next one needs to move to the "Messages" tab. The column "Message" should contain the number of the message and the column "Message Short Text" - the text, both according to what's prepared in the aformentioned comment section.
