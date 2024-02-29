#    File Name: dllist-step1.S
# File Created: 02/20/2024
#      Authors: Max Graves (mgraves4), Aaron Lewis (alewis25), Sam Monterola (smontero), Charlie Gussen (cgussen)

# Begin Code:

MAIN:

# x18 points to address 0x7ffff620 (location of dll_list per instructions)
lui  x5,  0x7ffff       # x5  = 0x7ffff000
addi x18, x5, 0x620     # x18 = 0x7ffff620 [&the_list]
add x5, x0, x0          # Clear x5
# end block

# Call the function calloc for dllist struct
add x12, x18, x0
jal x1, CALLOC_DLLIST
add x1, x0, x0          # clear - out of scope
add x12, x0, x0         # clear - out of scope

# Free dllist struct main call
add x12, x18, x0        # x12 = &the_list (x12 = address of the_list)
jal x1, FREE_DLLIST     # free(the_list)
add x1, x0, x0          # empty x1 since function has returned
add x12, x0, x0         # empty x12

# Return 0 
add x18, x0, x0
beq x0, x0, END

##########################################
# Procedure Name: CALLOC_DLLIST
# Pre-conditions: x12 contains the base address of an dll_node
# Post-conditions: x1 contains the return address of the calling procedure
#
# This procedure clears 128 bits (16 bytes) of memory 
# to be allocated to a dll_node
##########################################
CALLOC_DLLIST:

# calloc overwrites the memory at that location with 0
sw x0, 0(x12)           # Clears bytes 0-3
sw x0, 4(x12)           # Clears bytes 4-7
sw x0, 8(x12)           # Clears bytes 8-11
sw x0, 12(x12)          # Clears bytes 12-15

jalr x0, x1, 0          # jump and link back to main

##########################################
# Procedure Name: FREE_DLLIST
# Pre-conditions: x12 contains the base address of an dll_node
# Post-conditions: x1 contains the return address of the calling procedure 
#
# This procedure clears 128 bits (16 bytes) of memory 
# previously allocated to a dll_node
##########################################
FREE_DLLIST:

# Must clear the memory pointed to by x12 (16 bytes)
sw x0, 0(x12)           # Clears bytes 0-3
sw x0, 4(x12)           # Clears bytes 4-7
sw x0, 8(x12)           # Clears bytes 8-11
sw x0, 12(x12)          # Clears bytes 12-15

jalr x0, x1, 0          # jump and link back to main

END:
nop