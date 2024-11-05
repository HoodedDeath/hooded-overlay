# hoodeddeath-overlay

My own ebuild repository, for the sake of adding some programs that aren't elsewhere, as well as getting better at writing ebuilds

## Why have I made my own overlay?
1) This overlay started when I found that [muesli/deckmaster](https://github.com/muesli/deckmaster) was nowhere to be found in other overlays. That may be different now, as I initially started my learning of ebuilds a long while ago, but reason 2 still applies to app-misc/deckmaster.
2) Now that I'm learning to write my own ebuilds, I've decided that (for now at least) my systems will have just the official overlay, guru, and this one, so any additional packages I want are an opportunity for my to refine my ebuild writing.

## What's the main reason to use this overlay
There are currently two main reasons to use my overlay:

1) You want [muesli/deckmaster](https://github.com/muesli/deckmaster) for driving your Elgato Streamdeck. Available as app-misc/deckmaster
2) You have a fingerprint reader which requires the elanmoc2 patch/version of libfprint (Arch example is the AUR package [libfprint-elanmoc2-git](https://aur.archlinux.org/packages/libfprint-elanmoc2-git)). Available as sys-auth/libfprint. If you need this version, ensure this overlay is a higher priority than the official overlay in over to override the official sys-auth/libfprint. Note: This overriding setup is what I deemed a better solution than copying the official sys-auth/fprintd to something like sys-auth/fprintd-elanmoc2 in order to change the libfprint dependency to a libfprint-elanmoc2 dependency. Feedback welcome on that opinion

---

If you find yourself using this overlay and desiring it to have another package, feel free to open an issue or pull request. I am currently open to adding additional packages on request.
