# Multi Sequences Glimpse

This is the rapide viewer used in  [PkXplore](https://github.com/jpflandrs/PkXplore).

# What is done

It is currently limited to nucleic files.
A Fasta file ``inputfile`` corresponding to the set of sequences is transformed to a picture where the value of each base is rendered by a colored square.
When the ``alphabet_size`` is big enougth (>=19) the letter is also shown. Take care that if the sequences are long the letter cannot be read
The ``outputfile`` is a png file.
This is the ![final picture](https://github.com/jpflandrs/MSGlimpse/blob/main/aligned_crude.png) final picture from an alignment:

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

## License 

Avalaible under the CECIL license terms.
