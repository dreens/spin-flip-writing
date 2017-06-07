wordcount readme

To count words for PRL, do the following:
1. Open the PDF in Preview.
2. Select all text and copy into textedit as plain text.
3. Delete citations, tables, abstract, authors, acknowledgements, date, title.
4. Don’t delete captions or footnotes. The “nofootinbib” flag for revtex may be of use.
5. Save the text file, go to the shell and cat the file, pipe to “wc -c”.
6. Add 20+150/(width/height) for each figure, and 13+6.5*lines for tables.
7. Check the Texshop CONSOLE for figure aspect ratios, listed as width x height.
8. DON’T use the wordcount.sh shell script PRL recommends. It seems to have some latex version dependencies and the author is deceased.
9. If you’re close, CTRL+F all “- “ in your file and remove them. (hyphenated words over line breaks)

Try 1:
2848 words in textedit.
Figures: 150/(507.3/443.3) + 150/(1284.8/1374.2) + 150/(1257.498/963.6) + 150/(330/573.7) + 150/(336.9/312.8) = 806
Table: 13 + 6.5*8 = 65
2848 + 806 + 65 = 3719 < 3750, yay!

Try 2: (5/1/17)
3584 words in textedit.
Figures: 150/(369.2/249.8) + 150/(1247.9/952) + 150/(292.8/180.7) + 150/(348.3/535.0) + 150/(371.5/216.4) = 626
Table: 13 + 6.5*7 = 59
3584 + 626 + 59 = 4269 > 3750, BOO-HOO! 14% over.

Try 3: (5/2/17)
3085 words in textedit.
Figures: 150/(369.2/249.8) + 150/(1247.9/952) + 150/(292.8/180.7) + 150/(348.3/535.0) + 150/(371.5/216.4) = 626
Table: 13 + 6.5*7 = 59
3085 + 626 + 59 = 3770 > 3750, close enough to ignore???

Try 4: (6/4/17)
3134 words in textedit.
Figures: 150/(369.2/249.8) + 150/(1247.9/952) + 150/(292.8/180.7) + 150/(348.3/535.0) + 150/(371.5/216.4) = 626
Table: 13 + 6.5*7 = 59
3106 + 626 + 59 = 3791 > 3750, close enough to ignore???

Try 5: (6/6/17)
3061 words in textedit
Figures 100 + 150/(369.2/249.8) + 150/(1247.9/952) + 150/(292.8/180.7) + 150/(348.3/465.4) + 150/(371.5/216.4) = 696
Table: 13 + 8.5*7 = 72
3061 + 696 + 72 = 3829