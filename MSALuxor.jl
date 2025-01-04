try
    using Luxor
catch 
    import Pkg
    Pkg.add("Luxor")     
    using Luxor
end
try
    using Base.Iterators
catch
    import Pkg
    Pkg.add("Base.Iterators")     
    using Base.Iterators
end
try
    using ArgParse
catch
    import Pkg
    Pkg.add("ArgParse")     
    using ArgParse
end

"""
MSAluxor.jl is a part of the Web-Site engine PkXplore
It construct a picture of nucleic sequences alignment.
Copyright or © or Copr. UCBL Lyon, France;  
contributor : [Jean-Pierre Flandrois] ([2024/12/20])
[JP.flandrois@univ-lyon1.fr]

This software is a computer program whose purpose is to create the Web-Site PkXplore.

This software is governed by the [CeCILL|CeCILL-B|CeCILL-C] license under French law and
abiding by the rules of distribution of free software.  You can  use, 
modify and/ or redistribute the software under the terms of the [CeCILL|CeCILL-B|CeCILL-C]
license as circulated by CEA, CNRS and INRIA at the following URL
"http://www.cecill.info". 

As a counterpart to the access to the source code and  rights to copy,
modify and redistribute granted by the license, users are provided only
with a limited warranty  and the software's author,  the holder of the
economic rights,  and the successive licensors  have only  limited
liability. 

In this respect, the user's attention is drawn to the risks associated
with loading,  using,  modifying and/or developing or reproducing the
software by the user in light of its specific status of free software,
that may mean  that it is complicated to manipulate,  and  that  also
therefore means  that it is reserved for developers  and  experienced
professionals having in-depth computer knowledge. Users are therefore
encouraged to load and test the software's suitability as regards their
requirements in conditions enabling the security of their systems and/or 
data to be ensured and,  more generally, to use and operate it in the 
same conditions as regards security. 

The fact that you are presently reading this means that you have had
knowledge of the [CeCILL|CeCILL-B|CeCILL-C] license and that you accept its terms.

"""

function ArgParse.parse_item(::Type{Char}, x::AbstractString)
    return x[1]
end

function parse_commandline()
    s = ArgParseSettings()

    @add_arg_table! s begin

    "--couleurs", "-c"
        help = "colorscheme ex nuc1 " #numero donc -t prot -c 1 donnera le type 1 des couleurs de la sortie
        arg_type = String
        required = true
    "--input", "-i"
        help = "fasta entree"
        arg_type = String
        required = true
    "--output", "-o"
        help = "figure sortie"
        arg_type = String
        default = "msa_fig.svg"
    "--dimentions", "-d"
        help = "cotés du carré d'une base"
        arg_type = Int
        default = 5
    end
    return parse_args(s)
    
end

function ripolin(B::Vector{Vector{SubString{String}}}, formula::String) #on envoie la sequence et le nom du catalogue de peinture
    #https://juliagraphics.github.io/Luxor.jl/dev/howto/colors-styles/
    #O pyrrolysine
    #U selenocysteine
    println(formula)
    if formula === "nuc1"
        return map((j) -> [replace(i,"A" => "red", "T" => "blue","C" => "green4","G" => "yellow","N" => "grey","-" => "black","R"  => "grey","Y"  => "grey","K"  => "grey","M"  => "grey","S"  => "grey","W"  => "grey","B"  => "grey","D"  => "grey","H"  => "grey","V"  => "grey") for i in j],B)
    elseif formula === "nuc2" #guanines/pyrimidines = R/Y
        return map((j) -> [replace(i,"-" => "A" => "darkorange", "G" => "darkorange","C" => "palegreen4","T" => "palegreen4","N" => "grey","-" => "black","R"  => "grey","Y"  => "grey","K"  => "grey","M"  => "grey","S"  => "grey","W"  => "grey","B"  => "grey","D"  => "grey","H"  => "grey","V"  => "grey") for i in j],B)
    elseif formula == "prot1" #listes des AA comme seaview par defaut, couleurs un peu modifiées
        return map((j) -> [replace(i,"-" => "black","K"  => "red", "R" => "red" , "A"  => "royalblue3","F" => "royalblue3","I" => "royalblue3",
        "L" => "royalblue3","M" => "royalblue3","V" => "royalblue3","W" => "royalblue3","N"  => "green2", "Q" => "green2","S" => "green2",
        "T" => "green2","H"  => "cyan","Y" =>"cyan","C"  => "lightsalmon","D"  => "deeppink1","E" => "deeppink1","P"  => "yellow",
        "G"  => "orange","X"  => "darkgrey","O"  => "brown","U"  => "darkred"
        ) for i in j],B)
#, "A"  => "royalblue3","F" => "royalblue3","I" => "royalblue3","L" => "royalblue3","M" => "royalblue3","V" => "royalblue3","W" => "royalblue3","N"  => "green2", "Q" => "green2","S" => "green2","T" => "green2","H"  => "cyan","Y" =>"cyan","C"  => "lightsalmon","D"  => "deeppink1","E" => "deeppink1","P"  => "yellow","G"  => "orange","X"  => "darkgrey","O"  => "brown","U"  => "darkred"
    end
end

function panoramatographe(A::Vector{String},sortie::String,cotécarré::Int,couleur::String) #là on peut envoyer une matrice fasta donc on peut traiter les blasts de sortie
    # a partir de A on fabrique une liste de colorisation et une liste de nom de bases
    lmax=sort(map(x -> length(x),A),rev=true)[1]
        A=map(x-> x*"-"^(lmax-length(x)),A)
    B::Vector{Vector{SubString{String}}}= [split(i,"") for i in A] 
    colorisé::Vector{Vector{String}}= ripolin(B,couleur)
    couleursvector::Vector{String}= [(colorisé...)...] #la liste de 1 ... n
    bases::Vector{Char}=[(A...)...] # les noms des bases de 1 ... n
    type::String = "png"
    sortie=sortie*"."*type
    #println(length(B[1])*cotécarré,"  " ,length(A)*cotécarré)
    @png begin #defaut  pour le néobibi avec un carré de 15 ou 20 pour lettres sinon 5
        background("black")
        t::Table = Table(length(B), length(B[1]), cotécarré,cotécarré) # rows, columns, wide, high
        for (pt, n) in t
            setcolor(couleursvector[n])
            box(pt, cotécarré, cotécarré, :fill)
            setcolor("black")
            if cotécarré >=10
                fontsize(cotécarré/2)
                text(string(bases[n]), t[n], halign=:center, valign=:middle)
            end
        end
    end length(B[1])*cotécarré length(A)*cotécarré sortie #la taille de l'alignement
    return sortie
end

function lis_moi_fasta(entree::String)
    listkopf::Vector{String}=[]
    vecteurdessequences::Vector{String}=[]
    fileis = open(entree) do f
        localfasta::Vector{String}=[]
        localtete::String = ""
        while  !eof(f) #on utilise la voie rapide de lecture ligne à ligne 
            for l in eachline(f)
                if startswith(l,'>') #on débute un fasta mais...
                    if ! isempty(localfasta) #on vient de lire un fasta entier  donc localfasta est plein et on garde
                        push!(listkopf,localtete) #les noms dans l'ordre de l'alignement
                        push!(vecteurdessequences,join(localfasta,""))
                    end
                    localfasta=[] #initialisation du contenu
                    localtete=l #split(l,"\n")[2]   #affectation de la description
                else 
                    push!(localfasta,strip(l,['\n']))
                end
            end
        end
    end
    return vecteurdessequences
end

function main()
        args = parse_commandline()
        couleurs::String=args["couleurs"]
        jobin::String=args["input"]
        jobout::String=args["output"]
        cotécarré::Int=min(args["dimentions"],20)
        vecteurdessequences::Vector{String}=lis_moi_fasta(jobin)
        panoramatographe(vecteurdessequences,jobout,cotécarré,couleurs)

end
    
main()
