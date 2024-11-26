# Multi Sequences Glimpse

This is the rapide viewer used in  [PkXplore](https://github.com/jpflandrs/PkXplore).

# What is done

It is currently limited to nucleic files.
A Fasta file ``inputfile`` corresponding to the set of sequences is transformed to a picture where the value of each base is rendered by a colored square.
When the ``alphabet_size`` is big enougth (>=10) the letter is also shown. Take care that if the sequences are long the letter cannot be read
The ``outputfile`` is a png file.
This is the final picture from an alignment: ![final picture](https://github.com/jpflandrs/MSGlimpse/blob/main/aligned_crude.png) 
Where the colors are as follow:
![Colors](https://github.com/jpflandrs/MSGlimpse/blob/main/Chars.png)
# Usage

julia ```MSAluxor(inputfile,outputfile,alphabet_size)``` take care that the ```.png``` suffix is automatically added.
Using the minitest.fasta file 
```julia MSALuxor.jl -i minitest.fasta -o minitest -d 10```
the output is: ![minitest picture](https://github.com/jpflandrs/MSGlimpse/blob/main/minitest.png)

Note that in  [PkXplore](https://github.com/jpflandrs/PkXplore) a Vector of sequences is send directly to the function ```panoramatographe_nuc``` like here:

        exemple=["ATTCTGGTTGATCCTGCCAGAGGTTACTGCTATC","GATCCTGCCAGAGGTTACTGCTATCGGTGTTCGA",
        "ATTCTGGTTGATCCTGCCAGAGGTTACTGCTATC","GGTGTTCGACTAAGCCATGCTAGTTAAATGTTCT","TCGTGAACATAGCGGACTGCTCAGTAACACGTGGACAATCTGCCCTTGGGT","TCAGCATAACCCCGGGAAACTGGGGATAATTCTGAATAGATCACATATGCTGGAATGCTTTGT",
        "AACCTAAATTTCGCAAGGGGGGTTAAGTCGTAACAAGGTAGCCGTAGGGGAATCTGCGGCTGGATCACCTCCT"]
        panoramatographe_nuc(exemple,"fastaplottest.png",10)
## Limitations
Currently limites to nucleic sequences.
The length of the sequences is not limited. 
In PkXplore The maximal length is 3500 bp by construction (and the web-page). It works for bigger sequences but even using ```alphabet_size=1``` the picture may be difficult to read!

## License 

Avalaible under the CECIL license terms.
