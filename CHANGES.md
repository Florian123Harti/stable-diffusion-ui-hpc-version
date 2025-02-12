# What's new?

## v2.4
### Major Changes
- **Allow reordering the task queue** (by dragging and dropping tasks). Thanks @madrang
- **Automatic scanning for malicious model files** - using `picklescan`, and support for `safetensor` model format. Thanks @JeLuf
- **Image Editor** - for drawing simple images for guiding the AI. Thanks @mdiller
- **Use pre-trained hypernetworks** - for improving the quality of images. Thanks @C0bra5
- **Support for custom VAE models**. You can place your VAE files in the `models/vae` folder, and refresh the browser page to use them. More info: https://github.com/cmdr2/stable-diffusion-ui/wiki/VAE-Variational-Auto-Encoder
- **Experimental support for multiple GPUs!** It should work automatically. Just open one browser tab per GPU, and spread your tasks across your GPUs. For e.g. open our UI in two browser tabs if you have two GPUs. You can customize which GPUs it should use in the "Settings" tab, otherwise let it automatically pick the best GPUs. Thanks @madrang . More info: https://github.com/cmdr2/stable-diffusion-ui/wiki/Run-on-Multiple-GPUs
- **Cleaner UI design** - Show settings and help in new tabs, instead of dropdown popups (which were buggy). Thanks @mdiller
- **Progress bar.** Thanks @mdiller
- **Custom Image Modifiers** - You can now save your custom image modifiers! Your saved modifiers can include special characters like `{}, (), [], |`
- Drag and Drop **text files generated from previously saved images**, and copy settings to clipboard. Thanks @madrang
- Paste settings from clipboard. Thanks @JeLuf
- Bug fixes to reduce the chances of tasks crashing during long multi-hour runs (chrome can put long-running background tabs to sleep). Thanks @JeLuf and @madrang
- **Improved documentation.** Thanks @JeLuf and @jsuelwald
- Improved the codebase for dealing with system settings and UI settings. Thanks @mdiller
- Help instructions next to some setttings, and in the tab
- Show system info in the settings tab
- Keyboard shortcut: Ctrl+Enter to start a task
- Configuration to prevent the browser from opening on startup
- Lots of minor bug fixes
- A `What's New?` tab in the UI
- Ask for a confimation before clearing the results pane or stopping a render task. The dialog can be skipped by holding down the shift key while clicking on the button.
- Show the network addresses of the server in the systems setting dialog
- Support loading models in the safetensor format, for improved safety

### Detailed changelog
* 2.4.21 - 23 Dec 2022 - Speed up image creation, by removing a delay (regression) of 4-5 seconds between clicking the `Make Image` button and calling the server.
* 2.4.20 - 22 Dec 2022 - `Pause All` button to pause all the pending tasks. Thanks @JeLuf
* 2.4.20 - 22 Dec 2022 - `Undo`/`Redo` buttons in the image editor. Thanks @JeLuf
* 2.4.20 - 22 Dec 2022 - Drag handle to reorder the tasks. This fixed a bug where the metadata was no longer selectable (for copying). Thanks @JeLuf
* 2.4.19 - 17 Dec 2022 - Add Undo/Redo buttons in the Image Editor. Thanks @JeLuf
* 2.4.19 - 10 Dec 2022 - Show init img in task list
* 2.4.19 - 7 Dec 2022 - Use pre-trained hypernetworks while generating images. Thanks @C0bra5
* 2.4.19 - 6 Dec 2022 - Allow processing new tasks first. Thanks @madrang
* 2.4.19 - 6 Dec 2022 - Allow reordering the task queue (by dragging tasks). Thanks @madrang
* 2.4.19 - 6 Dec 2022 - Re-organize the code, to make it easier to write user plugins. Thanks @madrang
* 2.4.18 - 5 Dec 2022 - Make JPEG Output quality user controllable. Thanks @JeLuf
* 2.4.18 - 5 Dec 2022 - Support loading models in the safetensor format, for improved safety. Thanks @JeLuf
* 2.4.18 - 1 Dec 2022 - Image Editor, for drawing simple images for guiding the AI. Thanks @mdiller
* 2.4.18 - 1 Dec 2022 - Disable an image modifier temporarily by right-clicking it. Thanks @patriceac
* 2.4.17 - 30 Nov 2022 - Scroll to generated image. Thanks @patriceac
* 2.4.17 - 30 Nov 2022 - Show the network addresses of the server in the systems setting dialog. Thanks @JeLuf
* 2.4.17 - 30 Nov 2022 - Fix a bug where GFPGAN wouldn't work properly when multiple GPUs tried to run it at the same time. Thanks @madrang
* 2.4.17 - 30 Nov 2022 - Confirm before stopping or clearing all the tasks. Thanks @JeLuf
* 2.4.16 - 29 Nov 2022 - Bug fixes for SD 2.0 - remove the need for patching, default to SD 1.4 model if trying to load an SD2 model in SD1.4.
* 2.4.15 - 25 Nov 2022 - Experimental support for SD 2.0. Uses lots of memory, not optimized, probably GPU-only.
* 2.4.14 - 22 Nov 2022 - Change the backend to a custom fork of Stable Diffusion
* 2.4.13 - 21 Nov 2022 - Change the modifier weight via mouse wheel, drag to reorder selected modifiers, and some more modifier-related fixes. Thanks @patriceac
* 2.4.12 - 21 Nov 2022 - Another fix for improving how long images take to generate. Reduces the time taken for an enqueued task to start processing.
* 2.4.11 - 21 Nov 2022 - Installer improvements: avoid crashing if the username contains a space or special characters, allow moving/renaming the folder after installation on Windows, whitespace fix on git apply
* 2.4.11 - 21 Nov 2022 - Validate inputs before submitting the Image request
* 2.4.11 - 19 Nov 2022 - New system settings to manage the network config (port number and whether to only listen on localhost)
* 2.4.11 - 19 Nov 2022 - Address a regression in how long images take to generate. Use the previous code for moving a model to CPU. This improves things by a second or two per image, but we still have a regression (investigating).
* 2.4.10 - 18 Nov 2022 - Textarea for negative prompts. Thanks @JeLuf
* 2.4.10 - 18 Nov 2022 - Improved design for Settings, and rounded toggle buttons instead of checkboxes for a more modern look. Thanks @mdiller
* 2.4.9 - 18 Nov 2022 - Add Picklescan - a scanner for malicious model files. If it finds a malicious file, it will halt the web application and alert the user. Thanks @JeLuf
* 2.4.8 - 18 Nov 2022 - A `Use these settings` button to use the settings from a previously generated image task. Thanks @patriceac
* 2.4.7 - 18 Nov 2022 - Don't crash if a VAE file fails to load
* 2.4.7 - 17 Nov 2022 - Fix a bug where Face Correction (GFPGAN) would fail on cuda:N (i.e. GPUs other than cuda:0), as well as fail on CPU if the system had an incompatible GPU.
* 2.4.6 - 16 Nov 2022 - Fix a regression in VRAM usage during startup, which caused 'Out of Memory' errors when starting on GPUs with 4gb (or less) VRAM
* 2.4.5 - 16 Nov 2022 - Add checkbox for "Open browser on startup".
* 2.4.5 - 16 Nov 2022 - Add a directory for core plugins that ship with Stable Diffusion UI by default.
* 2.4.5 - 16 Nov 2022 - Add a "What's New?" tab as a core plugin, which fetches the contents of CHANGES.md from the app's release branch.
