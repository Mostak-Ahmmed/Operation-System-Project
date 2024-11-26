#!/bin/bash

## Operating System Algorithm Simulator Using Shell Script ##
## Md.Rabby Khan ID:213902037  
## Mostak Ahmeed ID:213902126

while true; do
    echo "Operating System Services Simulation Using Shell Script"
    echo "1. CPU Scheduling Algorithms"
    echo "2. Page Replacement Algorithms"
    echo "3. Contiguous Memory Allocation Algorithms"
    echo "4. Exit"
    read -p "Enter your choice (1-4): " choice

    case $choice in
        1)  # CPU Scheduling Algorithms
            # Arrays to store the results of each algorithm
            avg_waiting_times=()
            avg_turnaround_times=()
            algorithms=("Priority Scheduling" "SJF Scheduling" "FCFS Scheduling")

            while true; do
                echo "CPU Scheduling Algorithms"
                echo "1. Priority Scheduling"
                echo "2. SJF Scheduling"
                echo "3. FCFS Scheduling"
                echo "4. Show Best Algorithm"
                echo "5. Exit"
                read -p "Enter your choice (1-5): " cpu_choice

                case $cpu_choice in
                    1)  # Priority Scheduling
                        echo "Priority Scheduling Algorithm"
                        read -p "Enter the number of processes: " n
                        burst_time=()
                        priority=()
                        waiting_time=()
                        turnaround_time=()
                        process_number=()
                        for ((i = 1; i <= n; i++)); do
                            read -p "Enter the burst time for process $i: " bt
                            burst_time+=("$bt")
                            read -p "Enter the priority for process $i: " pr
                            priority+=("$pr")
                            waiting_time+=("0")
                            turnaround_time+=("0")
                            process_number+=("$i")
                        done

                        # Sort processes by priority, and in case of a tie, by burst time
                        for ((i = 0; i < n; i++)); do
                            for ((j = i + 1; j < n; j++)); do
                                if ((priority[i] > priority[j] || (priority[i] == priority[j] && burst_time[i] > burst_time[j]))); then
                                    tmp=${priority[i]}
                                    priority[i]=${priority[j]}
                                    priority[j]=$tmp
                                    tmp=${burst_time[i]}
                                    burst_time[i]=${burst_time[j]}
                                    burst_time[j]=$tmp
                                    tmp=${process_number[i]}
                                    process_number[i]=${process_number[j]}
                                    process_number[j]=$tmp
                                fi
                            done
                        done

                        # Calculate waiting and turnaround times
                        waiting_time[0]=0
                        for ((i = 1; i < n; i++)); do
                            waiting_time[i]=$((waiting_time[i - 1] + burst_time[i - 1]))
                        done
                        for ((i = 0; i < n; i++)); do
                            turnaround_time[i]=$((waiting_time[i] + burst_time[i]))
                        done

                        # Print the results
                        echo "Process | Burst Time | Priority | Waiting Time | Turnaround Time"
                        echo "------- | ---------- | -------- | ------------ | --------------"
                        for ((i = 0; i < n; i++)); do
                            echo "P${process_number[i]} | ${burst_time[i]} | ${priority[i]} | ${waiting_time[i]} | ${turnaround_time[i]}"
                        done

                        # Calculate the average waiting time and turnaround time
                        total_waiting_time=0
                        total_turnaround_time=0
                        for ((i = 0; i < n; i++)); do
                            total_waiting_time=$((total_waiting_time + waiting_time[i]))
                            total_turnaround_time=$((total_turnaround_time + turnaround_time[i]))
                        done
                        avg_waiting_time=$(awk "BEGIN {print $total_waiting_time / $n}")
                        avg_turnaround_time=$(awk "BEGIN {print $total_turnaround_time / $n}")

                        echo "Average Waiting Time: $avg_waiting_time"
                        echo "Average Turnaround Time: $avg_turnaround_time"

                        # Store the results
                        avg_waiting_times[0]=$avg_waiting_time
                        avg_turnaround_times[0]=$avg_turnaround_time
                        ;;
                    2)  # SJF Scheduling
                        echo "SJF Scheduling Algorithm"
                        read -p "Enter the number of processes: " n
                        burst_time=()
                        waiting_time=()
                        turnaround_time=()
                        process_number=()
                        for ((i = 1; i <= n; i++)); do
                            read -p "Enter the burst time for process $i: " bt
                            burst_time+=("$bt")
                            waiting_time+=("0")
                            turnaround_time+=("0")
                            process_number+=("$i")
                        done

                        # Sort processes by burst time
                        for ((i = 0; i < n; i++)); do
                            for ((j = i + 1; j < n; j++)); do
                                if ((burst_time[i] > burst_time[j])); then
                                    tmp=${burst_time[i]}
                                    burst_time[i]=${burst_time[j]}
                                    burst_time[j]=$tmp
                                    tmp=${process_number[i]}
                                    process_number[i]=${process_number[j]}
                                    process_number[j]=$tmp
                                fi
                            done
                        done

                        # Calculate waiting and turnaround times
                        waiting_time[0]=0
                        for ((i = 1; i < n; i++)); do
                            waiting_time[i]=$((waiting_time[i - 1] + burst_time[i - 1]))
                        done
                        for ((i = 0; i < n; i++)); do
                            turnaround_time[i]=$((waiting_time[i] + burst_time[i]))
                        done

                        # Print the results
                        echo "Process | Burst Time | Waiting Time | Turnaround Time"
                        echo "------- | ---------- | ------------ | --------------"
                        for ((i = 0; i < n; i++)); do
                            echo "P${process_number[i]} | ${burst_time[i]} | ${waiting_time[i]} | ${turnaround_time[i]}"
                        done

                        # Calculate the average waiting time and turnaround time
                        total_waiting_time=0
                        total_turnaround_time=0
                        for ((i = 0; i < n; i++)); do
                            total_waiting_time=$((total_waiting_time + waiting_time[i]))
                            total_turnaround_time=$((total_turnaround_time + turnaround_time[i]))
                        done
                        avg_waiting_time=$(awk "BEGIN {print $total_waiting_time / $n}")
                        avg_turnaround_time=$(awk "BEGIN {print $total_turnaround_time / $n}")

                        echo "Average Waiting Time: $avg_waiting_time"
                        echo "Average Turnaround Time: $avg_turnaround_time"

                        # Store the results
                        avg_waiting_times[1]=$avg_waiting_time
                        avg_turnaround_times[1]=$avg_turnaround_time
                        ;;
                    3)  # FCFS Scheduling
                        echo "FCFS Scheduling Algorithm"
                        read -p "Enter the number of processes: " n
                        burst_time=()
                        waiting_time=()
                        turnaround_time=()
                        process_number=()
                        for ((i = 1; i <= n; i++)); do
                            read -p "Enter the burst time for process $i: " bt
                            burst_time+=("$bt")
                            waiting_time+=("0")
                            turnaround_time+=("0")
                            process_number+=("$i")
                        done

                        # Calculate waiting and turnaround times
                        waiting_time[0]=0
                        for ((i = 1; i < n; i++)); do
                            waiting_time[i]=$((waiting_time[i - 1] + burst_time[i - 1]))
                        done
                        for ((i = 0; i < n; i++)); do
                            turnaround_time[i]=$((waiting_time[i] + burst_time[i]))
                        done

                        # Print the results
                        echo "Process | Burst Time | Waiting Time | Turnaround Time"
                        echo "------- | ---------- | ------------ | --------------"
                        for ((i = 0; i < n; i++)); do
                            echo "P${process_number[i]} | ${burst_time[i]} | ${waiting_time[i]} | ${turnaround_time[i]}"
                        done

                        # Calculate the average waiting time and turnaround time
                        total_waiting_time=0
                        total_turnaround_time=0
                        for ((i = 0; i < n; i++)); do
                            total_waiting_time=$((total_waiting_time + waiting_time[i]))
                            total_turnaround_time=$((total_turnaround_time + turnaround_time[i]))
                        done
                        avg_waiting_time=$(awk "BEGIN {print $total_waiting_time / $n}")
                        avg_turnaround_time=$(awk "BEGIN {print $total_turnaround_time / $n}")

                        echo "Average Waiting Time: $avg_waiting_time"
                        echo "Average Turnaround Time: $avg_turnaround_time"

                        # Store the results
                        avg_waiting_times[2]=$avg_waiting_time
                        avg_turnaround_times[2]=$avg_turnaround_time
                        ;;
                    4)  # Show Best Algorithm
                       echo "Comparing algorithms based on Average Waiting Time and Average Turnaround Time"
                        best_waiting_time=99999
                        best_turnaround_time=99999
                        best_waiting_algo=""
                        best_turnaround_algo=""

                        for ((i = 0; i < 3; i++)); do
                            if (( $(awk "BEGIN {print (${avg_waiting_times[i]} < $best_waiting_time)}") )); then
                                best_waiting_time=${avg_waiting_times[i]}
                                best_waiting_algo=${algorithms[i]}
                            fi
                            if (( $(awk "BEGIN {print (${avg_turnaround_times[i]} < $best_turnaround_time)}") )); then
                                best_turnaround_time=${avg_turnaround_times[i]}
                                best_turnaround_algo=${algorithms[i]}
                            fi
                        done


                        echo "Best Algorithm based on Average Waiting Time: $best_waiting_algo with $best_waiting_time"
                        echo "Best Algorithm based on Average Turnaround Time: $best_turnaround_algo with $best_turnaround_time"
                        ;;
                    5)  # Exit CPU Scheduling
                        break
                        ;;
                    *)  # Invalid Option
                        echo "Invalid option, please try again."
                        ;;
                esac
            done
            ;;
        2)  # Page Replacement Algorithms
            # Arrays to store the results of each algorithm
            page_faults=()
            algorithms=("FIFO Page Replacement" "LRU Page Replacement" "Optimal Page Replacement")

            while true; do
                echo "Page Replacement Algorithms"
                echo "1. FIFO Page Replacement"
                echo "2. LRU Page Replacement"
                echo "3. Optimal Page Replacement"
                echo "4. Show Best Algorithm"
                echo "5. Exit"
                read -p "Enter your choice (1-5): " page_choice

                case $page_choice in
                    1)  # FIFO Page Replacement
                        echo "FIFO Page Replacement Algorithm"
                        read -p "Enter the number of frames: " frames
                        read -p "Enter the number of pages: " n
                        pages=()
                        for ((i = 1; i <= n; i++)); do
                            read -p "Enter page reference $i: " page
                            pages+=("$page")
                        done

                        frame=()
                        faults=0

                        for ((i = 0; i < n; i++)); do
                            flag=0
                            for ((j = 0; j < ${#frame[@]}; j++)); do
                                if ((frame[j] == pages[i])); then
                                    flag=1
                                    break
                                fi
                            done
                            if ((flag == 0)); then
                                ((faults++))
                                if ((${#frame[@]} < frames)); then
                                    frame+=("${pages[i]}")
                                else
                                    frame=("${frame[@]:1}")
                                    frame+=("${pages[i]}")
                                fi
                            fi
                        done

                        echo "Total Page Faults using FIFO: $faults"
                        page_faults[0]=$faults
                        ;;
                    2)  # LRU Page Replacement
                        echo "LRU Page Replacement Algorithm"
                        read -p "Enter the number of frames: " frames
                        read -p "Enter the number of pages: " n
                        pages=()
                        for ((i = 1; i <= n; i++)); do
                            read -p "Enter page reference $i: " page
                            pages+=("$page")
                        done

                        frame=()
                        time=()
                        faults=0

                        for ((i = 0; i < n; i++)); do
                            flag=0
                            for ((j = 0; j < ${#frame[@]}; j++)); do
                                if ((frame[j] == pages[i])); then
                                    flag=1
                                    time[j]=$i
                                    break
                                fi
                            done
                            if ((flag == 0)); then
                                ((faults++))
                                if ((${#frame[@]} < frames)); then
                                    frame+=("${pages[i]}")
                                    time+=("$i")
                                else
                                    min=0
                                    for ((j = 1; j < ${#time[@]}; j++)); do
                                        if ((time[j] < time[min])); then
                                            min=$j
                                        fi
                                    done
                                    frame[$min]=${pages[i]}
                                    time[$min]=$i
                                fi
                            fi
                        done

                        echo "Total Page Faults using LRU: $faults"
                        page_faults[1]=$faults
                        ;;
                    3)  # Optimal Page Replacement
                        echo "Optimal Page Replacement Algorithm"
                        read -p "Enter the number of frames: " frames
                        read -p "Enter the number of pages: " n
                        pages=()
                        for ((i = 1; i <= n; i++)); do
                            read -p "Enter page reference $i: " page
                            pages+=("$page")
                        done

                        frame=()
                        faults=0

                        for ((i = 0; i < n; i++)); do
                            flag=0
                            for ((j = 0; j < ${#frame[@]}; j++)); do
                                if ((frame[j] == pages[i])); then
                                    flag=1
                                    break
                                fi
                            done
                            if ((flag == 0)); then
                                ((faults++))
                                if ((${#frame[@]} < frames)); then
                                    frame+=("${pages[i]}")
                                else
                                    index=0
                                    farthest=-1
                                    for ((j = 0; j < ${#frame[@]}; j++)); do
                                        
                                        for ((k = i + 1; k < n; k++)); do
                                            if ((frame[j] == pages[k])); then
                                                if ((k > farthest)); then
                                                    farthest=$k
                                                    index=$j
                                                fi
                                                break
                                            fi
                                        done
                                        if ((k == n)); then
                                            index=$j
                                            break
                                        fi
                                    done
                                    frame[$index]=${pages[i]}
                                fi
                            fi
                        done

                        echo "Total Page Faults using Optimal: $faults"
                        page_faults[2]=$faults
                        ;;
                    4)  # Show Best Algorithm
                        echo "Comparing algorithms based on Total Page Faults"
                        best_faults=99999
                        best_algo=""

                        for ((i = 0; i < 3; i++)); do
                            if ((page_faults[i] < best_faults)); then
                                best_faults=${page_faults[i]}
                                best_algo=${algorithms[i]}
                            fi
                        done

                        echo "Best Algorithm based on Total Page Faults: $best_algo with $best_faults faults"
                        ;;
                    5)  # Exit Page Replacement
                        break
                        ;;
                    *)  # Invalid Option
                        echo "Invalid option, please try again."
                        ;;
                esac
            done
            ;;
       3)  # Contiguous Memory Allocation Algorithms
            while true; do
                echo "Contiguous Memory Allocation Algorithms"
                echo "1. First Fit"
                echo "2. Best Fit"
                echo "3. Worst Fit"
                echo "4. Next Fit"
                echo "5. Contiguous Memory Allocation with Paging"
                echo "6. Back to Main Menu"

                read -p "Enter your choice (1-6): " mem_choice

                case $mem_choice in
                                1)  # First Fit
                                                            

                                echo "First Fit Contiguous Memory Allocation Algorithm"

                                # Read total memory size and number of blocks
                                read -p "Enter the total memory size: " total_memory
                                read -p "Enter the number of blocks: " num_blocks
                                block_sizes=()

                                # Read the size of each block
                                for ((i = 1; i <= num_blocks; i++)); do
                                    read -p "Enter the size of block $i: " block_size
                                    block_sizes+=("$block_size")
                                done

                                # Read the number of processes
                                read -p "Enter the number of processes: " num_processes
                                process_sizes=()

                                # Read the size of each process
                                for ((i = 1; i <= num_processes; i++)); do
                                    read -p "Enter the size of process $i: " process_size
                                    process_sizes+=("$process_size")
                                done

                                # Initialize allocation arrays
                                allocated_blocks=()
                                block_positions=()

                                # Initialize block positions
                                for ((i = 0; i < num_blocks; i++)); do
                                    block_positions+=(0)  # 0 indicates block is free
                                done

                                # Function to find the first fit block for a process
                                find_first_fit() {
                                    local process_size=$1
                                    for ((i = 0; i < num_blocks; i++)); do
                                        if ((block_positions[i] == 0 && block_sizes[i] >= process_size)); then
                                            echo $i
                                            return
                                        fi
                                    done
                                    echo -1
                                }

                                # Loop through each process to allocate memory
                                for ((i = 0; i < num_processes; i++)); do
                                    block_index=$(find_first_fit "${process_sizes[i]}")
                                    if ((block_index != -1)); then
                                        allocated_blocks+=("$block_index")
                                        block_positions[block_index]=1  # Mark block as used
                                        echo "Process $((i + 1)) allocated in block $((block_index + 1))"
                                    else
                                        allocated_blocks+=(-1)  # Indicate that the process could not be allocated
                                        echo "Insufficient memory for Process $((i + 1))"
                                    fi
                                done

                                # Print the final allocation table
                                echo ""
                                echo "File_no File_size Block_no Block_size Fragment"
                                for ((i = 0; i < num_processes; i++)); do
                                    if ((allocated_blocks[i] != -1)); then
                                        block_index=${allocated_blocks[i]}
                                        fragment=$((block_sizes[block_index] - process_sizes[i]))
                                        echo "$((i + 1)) | ${process_sizes[i]} | $((block_index + 1)) | ${block_sizes[block_index]}  |$fragment"
                                    else
                                        echo "$((i + 1)) ${process_sizes[i]} - - -"
                                    fi
                                done

                                ;;
                           2)  # Best Fit
                       echo "Best Fit Contiguous Memory Allocation Algorithm"

                        read -p "Enter the number of memory blocks: " m
                        blockSize=()

                        for ((i = 1; i <= m; i++)); do
                            read -p "Enter the size of block $i: " size
                            blockSize+=("$size")
                        done

                        read -p "Enter the number of processes: " n
                        processSize=()

                        for ((i = 1; i <= n; i++)); do
                            read -p "Enter the size of process $i: " size
                            processSize+=("$size")
                        done

                        allocation=()
                        blockAllocation=()
                        fragmentation=()

                        # Initialize allocation and fragmentation arrays
                        for ((i = 0; i < n; i++)); do
                            allocation[i]=-1
                            blockAllocation[i]=0
                            fragmentation[i]=0
                        done

                        for ((i = 0; i < n; i++)); do
                            bestIdx=-1
                            for ((j = 0; j < m; j++)); do
                                if (( blockSize[j] >= processSize[i] )); then
                                    if (( bestIdx == -1 )) || (( blockSize[bestIdx] > blockSize[j] )); then
                                        bestIdx=$j
                                    fi
                                fi
                            done

                            if (( bestIdx != -1 )); then
                                allocation[i]=$bestIdx
                                blockAllocation[i]=blockSize[bestIdx]
                                fragmentation[i]=$(( blockSize[bestIdx] - processSize[i] ))
                                blockSize[bestIdx]=$(( blockSize[bestIdx] - processSize[i] ))
                            fi
                        done

                        echo -e "\nFile_no | File_size| Block_no| Block_size | Fragment"
                        for ((i = 0; i < n; i++)); do
                            echo -n "$((i+1))\t ${processSize[i]}"
                            if (( allocation[i] != -1 )); then
                                echo -e "$(( allocation[i] + 1 ))\t\t${blockAllocation[i]}\t\t${fragmentation[i]}"
                            else
                                echo -e "Not Allocated\t\t0\t\t0"
                            fi
                        done
                        ;;
                    
                    3)  # Worst Fit
                       echo "Worst Fit Contiguous Memory Allocation Algorithm"

                        read -p "Enter the number of memory blocks: " m
                        declare -a blockSize

                        for ((i = 1; i <= m; i++)); do
                            read -p "Enter the size of block $i: " size
                            blockSize+=("$size")
                        done

                        read -p "Enter the number of processes: " n
                        declare -a processSize

                        for ((i = 1; i <= n; i++)); do
                            read -p "Enter the size of process $i: " size
                            processSize+=("$size")
                        done

                        declare -a allocation
                        declare -a blockCopy
                        declare -a fragment
                        allocation=()
                        fragment=()
                        blockCopy=("${blockSize[@]}")

                        # Initialize allocation array
                        for ((i = 0; i < n; i++)); do
                            allocation[i]=-1
                            fragment[i]=0
                        done

                        for ((i = 0; i < n; i++)); do
                            worstIdx=-1
                            for ((j = 0; j < m; j++)); do
                                if (( blockCopy[j] >= processSize[i] )); then
                                    if (( worstIdx == -1 )) || (( blockCopy[worstIdx] < blockCopy[j] )); then
                                        worstIdx=$j
                                    fi
                                fi
                            done

                            if (( worstIdx != -1 )); then
                                allocation[i]=$worstIdx
                                fragment[i]=$((blockCopy[worstIdx] - processSize[i]))
                                blockCopy[worstIdx]=0  # Mark the block as used by setting its size to 0
                            fi
                        done

                        echo -e "\nProcess No\tProcess Size\tBlock No\tBlock Size\tFragment"
                        for ((i = 0; i < n; i++)); do
                            if (( allocation[i] != -1 )); then
                                echo -e "$((i+1))\t\t${processSize[i]}\t\t$(( allocation[i] + 1 ))\t\t${blockSize[allocation[i]]}\t\t${fragment[i]}"
                            else
                                echo -e "$((i+1))\t\t${processSize[i]}\t\tNot Allocated\t\t0\t\t0"
                            fi
                        done
                        ;;

                    4)  # Next Fit
                          echo "Next Fit Contiguous Memory Allocation Algorithm"

                            read -p "Enter the total memory size: " total_memory
                            read -p "Enter the number of processes: " num_processes
                            process_sizes=()

                            for ((i = 1; i <= num_processes; i++)); do
                                read -p "Enter the size of process $i: " size
                                process_sizes+=("$size")
                            done

                            current_position=0
                            allocated_blocks=()

                            for ((i = 0; i < num_processes; i++)); do
                                while ((current_position + process_sizes[i] > total_memory && current_position < total_memory)); do
                                    current_position=$((current_position + 1))
                                done
                                if ((current_position + process_sizes[i] <= total_memory)); then
                                    allocated_blocks+=("$current_position")
                                    echo "Process $((i + 1)) allocated at position $current_position"
                                    current_position=$((current_position + process_sizes[i]))
                                else
                                    echo "Insufficient memory for Process $((i + 1))"
                                fi
                            done

                            ;;
                        5)  # Contiguous Memory Allocation with Paging
                       echo "Under Progress..."
                        ;;
                        
                     

                      
                    6)  # Back to Main Menu
                        break
                        ;;
                    *)  # Invalid Choice
                        echo "Invalid choice. Please enter a valid option."
                        ;;
                esac
            done
            ;;
        4)  # Exit
            echo "Exiting the simulation. Goodbye!"
            exit 0
            ;;
        *)  # Invalid Choice
            echo "Invalid choice. Please enter a valid option."
            ;;
    esac
done

