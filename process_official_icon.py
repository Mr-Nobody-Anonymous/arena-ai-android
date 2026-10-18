"""Regenerates the Android launcher icons from the official Arena.ai source art.

Usage (from the repository root):

    python3 process_official_icon.py

Set ARENA_RES_DIR to write somewhere other than the Android resource directory
(used by the automated check).
"""

import os

from PIL import Image

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
SOURCE_ICON = os.path.join(BASE_DIR, "official_apple_touch_icon_dark.png")
RES_DIR = os.environ.get(
    "ARENA_RES_DIR",
    os.path.join(BASE_DIR, "android", "app", "src", "main", "res"),
)

MIPMAP_SIZES = {
    "mipmap-mdpi": 48,
    "mipmap-hdpi": 72,
    "mipmap-xhdpi": 96,
    "mipmap-xxhdpi": 144,
    "mipmap-xxxhdpi": 192,
}


def _round_icon(image):
    """Applies a circular mask for launchers that do not use adaptive icons."""
    size = image.size[0]
    mask = Image.new("L", (size, size), 0)
    from PIL import ImageDraw

    draw = ImageDraw.Draw(mask)
    draw.ellipse((0, 0, size - 1, size - 1), fill=255)
    rounded = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    rounded.paste(image, (0, 0), mask)
    return rounded


def main():
    if not os.path.isfile(SOURCE_ICON):
        raise SystemExit(f"Source icon not found: {SOURCE_ICON}")

    image = Image.open(SOURCE_ICON).convert("RGBA")
    written = 0

    for folder, size in MIPMAP_SIZES.items():
        target_dir = os.path.join(RES_DIR, folder)
        os.makedirs(target_dir, exist_ok=True)

        resized = image.resize((size, size), Image.Resampling.LANCZOS)
        resized.save(os.path.join(target_dir, "ic_launcher.png"))
        _round_icon(resized).save(os.path.join(target_dir, "ic_launcher_round.png"))
        written += 2

    print(f"Wrote {written} launcher icons to {RES_DIR}")


if __name__ == "__main__":
    main()
