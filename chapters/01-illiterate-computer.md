# Chapter 1: The Illiterate Computer

## Opening Example

It's November 17, 2025, and I'm staring at my MikroTik RB5009 router. It's handling over 25,000 active connections, routing traffic for my entire home infrastructure, and sitting there silently doing exactly what it's programmed to do. The router knows everything happening on my network: which devices are connected, how much bandwidth they're using, when connections fail, what's slow, what's fast. It has all this information, but it can't tell me about it unless I know exactly which commands to type, which web interface pages to navigate, which specific buttons to click.

The router is extraordinarily capable. It's just completely illiterate.

By illiterate, I don't mean it can't display text or process commands. I mean it can't understand what I want. When I'm concerned about network performance, I can't ask it "Is everything running smoothly?" When I notice my WiFi feels slow, I can't say "What's using all the bandwidth?" The router sits there with all the answers, waiting for me to translate my intent into its language: CLI commands, API calls, or precise sequences of clicks through a web interface.

This is the defining characteristic of traditional computing. Computers are event-polling machines. They respond to specific inputs with specific outputs. Press this button, get that result. Type this command, receive that response. They are extraordinarily good at this, but they have no semantic understanding of what you're trying to accomplish or why you're trying to accomplish it.

## Core Concept

Traditional computers are illiterate in the sense that they cannot read intent. They process events but don't understand meaning. This creates a persistent translation burden: humans must convert what they want into the specific language the computer expects. We've gotten so used to this burden that we barely notice it anymore. We call systems "user-friendly" when the translation is slightly easier to remember, and we call people "tech-savvy" when they've memorized more translations than average.

But the burden remains, and it compounds. Every new system requires learning a new translation. Every update potentially changes the translation. Every task that should be simple becomes a multi-step process of converting human intent into machine-compatible instructions.

This chapter explores what it means for computers to be illiterate, why the graphical user interface revolution didn't actually solve this problem, and what the mental weight of this constant translation costs us.

## The Event-Polling Prison

Let's be precise about what we mean by "event-polling." A traditional computer doesn't understand context or intent. It watches for events: keyboard presses, mouse clicks, network packets, timer ticks. When an event occurs, the computer executes whatever code is associated with that event. Click here, run this function. Press that key, execute that command. Receive this network packet, process it according to this protocol.

This is not a limitation of computing power. A modern smartphone has more processing capacity than the supercomputers that sent humans to the moon. The limitation is one of interface design: computers are designed to respond to precisely specified inputs, not to understand what you're trying to accomplish.

Consider what happens when you want to check if your network is healthy. With a MikroTik router, you might:

1. Open a web browser
2. Navigate to the router's IP address
3. Log in with credentials
4. Click through several menu levels to find connection statistics
5. Read a table of numbers and interpret what they mean
6. Navigate to a different menu to check bandwidth usage
7. Navigate to another menu to check for error logs
8. Mentally synthesize all this information to answer your original question: "Is my network healthy?"

Every single one of these steps is an event that triggers a response. The computer doesn't know you're investigating network health. It only knows you clicked this button, so it shows you this page. You requested this URL, so it serves you this data. You submitted this form, so it authenticates you.

The computer has all the information needed to answer "Is my network healthy?" but it can't answer that question. It can only respond to specific events with specific outputs. The burden of synthesis, interpretation, and understanding falls entirely on you.

## The GUI Myth

In the 1980s, graphical user interfaces promised to make computers accessible to everyone. No more memorizing arcane command syntax. No more typing cryptic abbreviations. Instead, you could see your options and click on them. The interface would guide you visually through what was possible.

And GUIs did make computers more accessible. They absolutely eliminated a significant barrier: the need to memorize command names and syntax. Before GUIs, using a computer required knowing that you could type `ls -la` to list files or `rm -rf` to delete directories. You had to know these commands existed, remember their exact names, and understand their parameters. This was a genuine barrier to entry.

But GUIs didn't eliminate the need to learn. They just replaced one form of learning with another.

Instead of memorizing `cd /var/log && tail -f syslog.log`, you memorize a click sequence: "Open Finder, navigate to Macintosh HD, open the var folder, scroll to find log, find the right log file, double-click to open, scroll to the bottom." Instead of typing a command, you're executing a visual program: a specific sequence of clicks and navigations that achieves a specific result.

This is still a translation burden. You still have to know the sequence exists. You still have to remember the specific steps. You still have to translate your intent ("I want to see recent system errors") into the computer's language (the precise sequence of clicks that will show you the log file).

The GUI is often easier to discover than the CLI. You can browse menus to see what's possible. You can explore by clicking around. But once you've discovered what you need to do, you still have to remember it. The click sequence becomes your new command to memorize.

And here's the crucial insight: GUIs introduced new inefficiencies that CLIs didn't have. With a CLI, once you know the command, you can type it quickly, script it, automate it. With a GUI, you have to perform the entire click sequence every single time. You can't easily tell someone else how to do it. You can't script it. You can't automate it without specialized tools.

We called this progress because more people could use computers. But we didn't solve the fundamental problem: computers still couldn't understand what we wanted. We just made the translation process more visual.

## Visual Programming

Let's call it what it is: when you execute a sequence of clicks to accomplish a task, you are programming the computer. You are providing a sequence of instructions that the computer executes. The fact that you're doing it with a mouse instead of a keyboard doesn't change the fundamental nature of what's happening.

Consider checking your email:
1. Open browser
2. Navigate to mail provider
3. Enter credentials
4. Click "Inbox"
5. Scan subject lines
6. Click specific message
7. Read content

This is a program. It's a sequence of conditional operations with defined inputs and outputs. You've learned this program through repetition. You execute it daily. When the interface changes, your program breaks and you have to learn a new one.

The difference between this and traditional programming is merely that the computer provides visual affordances for each step. Buttons instead of function names. Menus instead of parameters. But you're still translating intent ("check email") into a precise sequence of operations that the computer can execute.

And like traditional programming, visual programming requires you to understand the system's mental model. You need to know that email lives in "Inbox." You need to know that you access it through a browser. You need to know the difference between "Archive" and "Delete." The computer won't help you if you have the wrong mental model. It will just execute whatever events you trigger.

## The Mental Weight

There's a cost to all this translation that we rarely acknowledge: the mental weight of unrealized potential.

You know your computer could do more. You know your router has the information you need. You know your phone could automate that repetitive task. You know the data you need exists somewhere in that application. But accessing it requires learning yet another interface, memorizing yet another sequence, translating yet another intent into machine-compatible instructions.

So often, you just don't. You work around it. You do things manually. You settle for not knowing. You live with the inefficiency because the cost of learning the translation exceeds the benefit of the automation.

This is the mental weight: the constant awareness of unrealized potential, coupled with the knowledge that realizing it requires effort you may not have time for right now.

Every experienced computer user carries a mental backlog of things they wish their computer could do: scripts they haven't written, automations they haven't configured, integrations they haven't set up. These aren't impossible tasks. They're just tasks that require translating clear intent into computer-compatible instructions, and that translation takes time and expertise.

## Network Monitoring Before Literacy

Let me give you a concrete example from my infrastructure work. I wanted to monitor network health and display it in my macOS menu bar. Simple goal: see at a glance if everything is working.

To accomplish this without AI assistance, I would need to:

1. Learn the MikroTik API or CLI commands
2. Understand what metrics indicate health
3. Write a script that queries these metrics
4. Parse the response format
5. Decide on threshold values for "healthy" vs "unhealthy"
6. Format the output for SwiftBar (my menu bar tool)
7. Handle errors and edge cases
8. Test across different network conditions
9. Debug when something doesn't work
10. Maintain it when APIs change

Every step requires translation. I need to translate "network health" into specific metrics. I need to translate those metrics into API calls. I need to translate API responses into script logic. I need to translate script output into SwiftBar format.

I could do this. I have the skills. But it would take hours. So like many such tasks, it would sit on my mental backlog, unrealized potential weighing on me every time I manually checked if the network was working.

This is the state of traditional computing: surrounded by capable machines that can't understand what we want.

## The Click Economy

We've built an entire economy around this illiteracy. Technical documentation teaches you the correct click sequences. Video tutorials show you the exact visual path to follow. Forums are full of people asking "how do I..." and receiving answers in the form of step-by-step instructions: click here, then here, then type this, then click there.

Millions of people independently learn the same sequences. The knowledge is duplicated in millions of heads, documented in thousands of forum posts, explained in countless tutorials. Each person has to discover (or be told) that to accomplish task X, you perform sequence Y.

This is extraordinarily inefficient. We're violating the DRY principle (Don't Repeat Yourself) at global scale. The same knowledge is being encoded, stored, retrieved, and executed millions of times over, independently, with no systematic compilation.

But it's the inevitable result of illiterate computers. If the computer can't understand what you want, someone has to know the translation. And if the translation can't be compiled into the system itself, it has to be duplicated in every user's head.

## When Potential Stays Unrealized

The saddest part of computer illiteracy is all the potential that never gets realized. How many times have you thought "I wish this could just..." and then shrugged and done it manually? How many small inefficiencies do you live with because automating them would require learning something new?

Your computer could probably do that thing you want. The capability exists. The information is accessible. The APIs are documented. But translating your intent into the computer's language would take hours you don't have, learning you haven't done, expertise you may not possess.

So the potential sits there, unrealized. Your capable computer waiting for instructions it will understand, while you do things the hard way because the translation burden is too high.

This is what it means for computers to be illiterate. Not that they lack capability, but that they can't read your intent. They can only respond to precisely specified events, and specifying those events requires you to speak their language.

## Practical Patterns

If you're reading this chapter and recognizing the patterns in your own work, here's what to notice:

1. **Translation burden**: Count how many steps stand between your intent and the result. "I want to know X" might require 10 clicks, 3 menu navigations, and manual interpretation of results.

2. **Duplicated knowledge**: Notice when you're learning something that millions of others have also learned. That's a sign the knowledge hasn't been compiled into the system.

3. **Unrealized potential**: Keep a list of things you wish your computer could do but haven't implemented. This is your mental backlog of translation tasks.

4. **Visual programs**: Pay attention to sequences you've memorized. These are programs you're executing manually.

5. **The learning treadmill**: Notice when an interface update breaks your memorized sequences. This is your program requiring maintenance because the computer didn't understand what you were trying to accomplish.

## Common Pitfalls

When thinking about computer illiteracy, avoid these traps:

1. **Blaming users**: This isn't about users being insufficiently technical. Expert users face the same translation burden, just with a larger vocabulary.

2. **Praising GUIs uncritically**: GUIs were progress, but they didn't solve the core problem. Recognizing this isn't nostalgia for the CLI era.

3. **Assuming capability limits**: Most "I wish my computer could..." thoughts are about interface problems, not capability problems. The computer usually can, you just can't tell it to.

4. **Accepting inefficiency**: "That's just how computers work" is true for illiterate computers, but it's not fundamentally true for all possible computers.

5. **Forgetting the weight**: The mental burden of unrealized potential is real even if it's hard to quantify.

## Summary

- Traditional computers are illiterate: they process events but don't understand intent
- GUIs replaced command memorization with click sequences but didn't eliminate the translation burden
- Click sequences are visual programs that you execute manually
- The mental weight of unrealized potential is a real cost of computer illiteracy
- Millions of people independently learn the same translations, violating DRY at global scale
- Most "impossible" tasks are actually "high translation cost" tasks
- Capability exists; what's missing is the ability to express intent in human terms

The illiterate computer is extraordinarily capable. It just can't understand what you want. Everything you accomplish requires translating your intent into its language: commands, clicks, API calls, configuration files. This translation burden is so pervasive we barely notice it.

But we're about to notice. Because computers are learning to read.
