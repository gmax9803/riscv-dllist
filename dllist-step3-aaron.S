#    File Name: dllist-step2.S
# File Created: 02/28/2024
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

# Setting up the first main loop
addi x19, x0, 3   # y = 3

BEGIN_FOR: 
bge x0, x19, END_FOR

# Set up the looop
# Check if... the_list->head_node == NULL
IF: 
lw x7, 0(x18)
bne x7, x0, ELSE

sw x28, 4(x18)      # the_list->tail_node = made_node
# Get the address of x18 + 12 bytes
addi x28, x18, 16
sw x0, 0(x28)
sw x0, 4(x28)
sw x0, 8(x28)
sw x0, 12(x28)

# Set data value of node and update head + tail
sw x19, 0(x28)   	# made_node->the_int = y;
sw x28, 0(x18)		# the_list->head_node = made_node;
sw x28, 4(x18)      # the_list->tail_node = made_node

# Clear local registersand branch to END_IF
add x28, x0, x0  # x28 goes out of scope before ELSE_IF
beq x0, x0, END_IF

# We will add ELSE here, but nothing else before step 7.4
ELSE:

######################################################
#### THE CHANGE FOR THE LIST ITERATOR STARTS HERE ####
######################################################

# Iterate through the list to find the next node location
# Get the location of the head nodr from head_ptr
lw x28, 0(x18)	# sll_node* curr_ptr = the_list->head_node;

# Develop the while loop
WHILE:

lw x29, 8(x28)			# x29 = curr_ptr->next_node (8 bytes because structure is val,prev,next... jump from val to next)
beq x29, x0, END_WHILE	# Exit the while loop if curr_ptr->next_node == NULL

# These two instructions make up:
# curr_ptr = curr_ptr->next_node;
add x28, x29, x0		# Set x28 to x29
lw x29, 8(x28)			# Load the next

beq x0, x0, WHILE

END_WHILE:

####################################################
#### THE CHANGE FOR THE LIST ITERATOR ENDS HERE ####
####################################################
#################################################################
#### THE CHANGE FOR ENTERING THE END OF THE LIST STARTS HERE ####
#################################################################

# Enter the node at the end of the linked list, which is already found
# sll_node* made_node = ( sll_node* )calloc( 1, sizeof(sll_node) );
addi x29, x28, 0x10 # next node is 16 bytes ahead
sw x0, 0(x29)
sw x0, 4(x29)
sw x0, 8(x29)
sw x0, 12(x29)

# made_node->the_int = y;
sw x19, 0(x29)

# curr_ptr->next_node = made_node;
sw x29, 8(x28)
sw x28, 4(x29)

# Clear x7, decrement  y--, and branch back to BEGIN_FOR
END_IF:
add x7, x0, x0   # Clear x7 since it is about to go out of scope
add x29, x0, x0  ###### FIX - Step 9.4 - Clear x29 since it is about to go out of scope

###############################################################
#### THE CHANGE FOR ENTERING THE END OF THE LIST ENDS HERE ####
###############################################################

addi x19, x19, -1      # y--;
beq x0, x0, BEGIN_FOR # Go back to the beginning of the loop

END_FOR:
add x6, x0, x0

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
# Post-conditions: 
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
