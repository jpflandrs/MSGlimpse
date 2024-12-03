# Multi Sequences Glimpse

This is a qwick multi-sequences viewer developped initialy for [PkXplore](https://pkxplore.univ-lyon1.fr/nucworkshop), here [its GitHub](https://github.com/jpflandrs/PkXplore). The aim is to get a glimpse to an alignment of sequences to detect visually its global quality like [here](https://github.com/jpflandrs/PkXplore/blob/main/PkXplorer.pdf).

# What is done

A Fasta file ``inputfile`` corresponding to the set of sequences is transformed to a picture where the value of each base is rendered by a colored square.
When the ``alphabet_size`` is big enougth (>=10) the letter is also shown (larger is better). Take care that if the sequences are long the letter cannot be read without zooming.
The ``outputfile`` is a png file.

This is the final picture from a nucleic alignment: ![final picture](https://github.com/jpflandrs/MSGlimpse/blob/main/aligned_crude.png)
Black is representing gaps.
Here a [protein alignment](https://github.com/jpflandrs/MSGlimpse/blob/main/proteinview.png)

# Usage

- Run ```julia MSAluxor -i inputfile -o outputfile -d alphabet_size -c color_scheme``` take care that the ```.png``` suffix is automatically added.
- ```color_scheme``` is currently:
- 1) Nucleic sequences : nuc1 (A/T/G/C/N) ![Colors](https://github.com/jpflandrs/MSGlimpse/blob/main/CharsNuc.png), nuc2 (R/Y).
- 2) Protein sequences : prot1 (KR,AFILMVW,NQST,HY,C,DE,P,G,O,U) ![prot1](https://github.com/jpflandrs/MSGlimpse/blob/main/CharsProt.png).
- ``` alphabet_size ``` is an integer.

- Using the minitest.fasta file
```julia MSALuxor.jl -i minitest.fasta -o minitest -d 20 -c nuc1```
the output is: ![minitest picture](https://github.com/jpflandrs/MSGlimpse/blob/main/minitest.png)

- Note that in  [PkXplore](https://github.com/jpflandrs/PkXplore) a Vector of sequences is send directly to the function ```panoramatographe_nuc``` like here:

        exemple=["ATTCTGGTTGATCCTGCCAGAGGTTACTGCTATC","GATCCTGCCAGAGGTTACTGCTATCGGTGTTCGA",
        "ATTCTGGTTGATCCTGCCAGAGGTTACTGCTATC","GGTGTTCGACTAAGCCATGCTAGTTAAATGTTCT","TCGTGAACATAGCGGACTGCTCAGTAACACGTGGACAATCTGCCCTTGGGT","TCAGCATAACCCCGGGAAACTGGGGATAATTCTGAATAGATCACATATGCTGGAATGCTTTGT",
        "AACCTAAATTTCGCAAGGGGGGTTAAGTCGTAACAAGGTAGCCGTAGGGGAATCTGCGGCTGGATCACCTCCT"]
        panoramatographe_nuc(exemple,"fastaplottest.png",10)

- In our lab, outside PkXplore, it is widely used to get a glimpse on the alignment of protein families when building a bacteria/archaea core-genome.

## Limitations

- Currently limited color_schemes

- The length of the sequences is not limited and the pictures are not very informative if the sequences (or one of the sequences) is very long! Do not try with a 150,000 bp alignment!. In PkXplore The maximal length is 3500 bp by construction (web-page rendering). It works for bigger sequences but even using ```alphabet_size=1``` the picture may be difficult to read!

- The letters [A,T,G,C,N] are readable only when ```alphabet_size``` is set to 20, under this value the output is fuzzy. Usually the ```alphabet_size``` value is set to 4 and the output is only composed of colored squares.

- Memory ans speed: as long as the number of sequences is low (perhaps 200) and the length of the alignment is under 5000 bp, the speed remains acceptable and the memory usage is low. The PkXplore conditions are: less than 75 sequences and less than 3500bp, in this case the result is immediate. An exemple is given with 911 aligned sequences of length 4283 (```alphabet_size=1```, 42 seconds running, 0.8Go memory used): ![maxitest picture](https://github.com/jpflandrs/MSGlimpse/blob/main/maxitest.png) Using this tool remains possible in limited cases with such a relatively big multiple fasta but is not encouraged :)

## Why Luxor

- Why not ? Luxor is a **great** tool in pure Julia.

- I like Luxor and I am used to so that the solution was easy to write.

## License

Avalaible under the CECIL license terms.
