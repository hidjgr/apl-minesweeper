⍝ Minesweeper in Dyalog!
⍝ Brought to you by Hichem Djeghri

shift ← ((∘.,⍨¯1 0 1)∘((1∘↓¨⊣)⌽¨(1∘↑¨⊣)⊖¨⊢))(3 3∘⍴⊂)⍝ Takes a matrix as argument and produces a 3×3 array of the same matrix rotated accordingly
toprow ← ((⍴∘1(⍴1∘↑))⍪(⍴∘0(⍴1∘↓)))                    ⍝ Produces a matrix with a top row of 1s and the rest 0s of the same shape as its argument
leftcol ← ⍉(toprow⍉)                                ⍝ Ditto for the first column
newgame ← (⊣⍴(⊂((×/⊣)?(×/⊣)))⌷(/∘1 0 (⊢,((×/⊣)-⊢))))  ⍝ Produces a random layout of shape ⍺ with ⍵ mines

part3 ← ((⊂((÷∘3 ≢)↑⊢)),(⊂(((÷∘2 ≢)↑⊢) ((÷∘3 ≢)↓⊢))),(⊂(((- ÷∘3) ≢)↑⊢)))
part9 ← ((⍉¨(↑(part3 ⍉)¨))part3)                    ⍝ Partition a 3n×3m matrix into a 3×3 matrix of n×m matrices

edges ← ((⊢∨(⌽⊖))((toprow∨leftcol) (3∘/ 3∘⌿)))      ⍝ Create a matrix of shape 3×⍴⍵
edgemask ← part9 edges                                ⍝ Partition that matrix

neighbors ← ↑(+/(+/((~edgemask)⌊shift)))              ⍝ Counts mines surrounding tiles
grid ← (neighbors⌊(-∘1(10∘×~)))                       ⍝ Replaces the mine tiles with ¯1

expand ← ↑(⌈/(⌈/((~edgemask)⌊shift)))                 ⍝ Expands the 1s in a boolean matrix in every direction until the edges are reached
fillspace ← ((⊢∨(expand (0∘=(grid ⊣))∧⊢))⍣≡)          ⍝ Expands the 1s in ⍵ over ⍺ untill all reachable 0s in ⍺ are covered

disp ← {'⎕* 12345678'[3+(grid ⍺)⌊(2-⍨10×⍵)]}          ⍝ Display the game ""graphically""
play ← {(⍵⌷S)←1⋄⎕←M disp M fillspace S⋄M fillspace S} ⍝ Play, requires the game layout to be called M, and the revealed tiles S (initially a zero matrix of shape ⍴M)
                                                      ⍝ Reveals the tile at coordinate ⍵
						                                          ⍝ Must manually create and then update S, call like so: S ← play x y

⍝ M ← x y newgame n
⍝ S ← (⍴M)⍴0

⍝ S ← play x y ...
