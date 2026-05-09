# Visual Prompt Architect

> Candidate skill. Model-agnostic. Expands as specific image/video gen tools lock in.
> Owner: Mystique (58_Mystique/). Built: 2026-04-11.

---

## Trigger

When Andras (or Mystique) needs to generate a visual -- drone shot, product render, parallax loop, hero image, POD graphic, TikTok clip, anything -- and needs a structured prompt ready for a gen tool.

---

## What This Skill Does

Takes a rough visual idea and structures it into a layered prompt architecture that works with any image or video generation tool (ComfyUI, Seedance, local diffusion, future Pylon models, etc.).

The structure forces clarity before generation. Bad input = bad output. This skill fixes input.

---

## The Five Layers

Every visual prompt has five layers. Fill all five.

```
SCENE GOAL
[What is happening or existing in this frame? One sentence. Physical, not abstract.]
Example: "A ceramic mug sits on a rain-wet wooden table, steam rising."

SUBJECT + PHYSICS
[What are the objects/subjects? How does gravity, light, and material interact with them?]
Example: "Mug: matte terracotta glaze, heavy, slightly imperfect. Wood: dark walnut grain, water beading on surface."

MOTION (video only -- skip for static image)
[What moves, how, how fast, in what direction? Camera or subject or both?]
Example: "Slow parallax push-in toward the mug. Steam wisps upward. No camera shake."

LIGHTING + MOOD
[Time of day, light source, color temperature, emotional tone.]
Example: "Golden hour backlight through a rain-streaked window. Warm 3200K. Melancholy-cozy."

CAMERA + COMPOSITION
[Lens feel, shot type, rule of thirds, depth of field, aspect ratio.]
Example: "85mm equivalent. Shallow DOF, subject sharp, background soft bokeh. 16:9 cinematic. Subject at left third, steam in negative space."
```

---

## Output Format

When this skill runs, produce:

**STRUCTURED PROMPT** (paste directly into gen tool):
```
[Combine all five layers into a clean, ordered paragraph. Most gen tools read top-to-bottom, so put the most important visual information first.]
```

**SHORT PROMPT** (for tools with token limits):
```
[50-word version -- scene, lighting, camera only]
```

**NEGATIVE PROMPT** (for diffusion models):
```
blurry, oversaturated, plastic, CGI, watermark, text, logo, ugly hands, distorted
[Add specifics based on what the scene should NOT be]
```

**GEN TOOL RECOMMENDATION**:
```
[Given current Forge toolset, which tool to use right now:]
- Static image: ComfyUI on The Forge (AMD 6700 XT, SDXL base model)
- Animated/video: [PENDING -- Pylon June 2, or free API when available]
- Quick concept: Claude image gen (Canva MCP for layout)
```

---

## How Mystique Uses This

Mystique invokes this skill when:
- Designing POD graphics (Nimloren Press) -- the "visual feel" before Canva layout
- Building TikTok content -- scripting the visual language of a shot before record
- Generating product renders for Pepper Potts pipeline
- Any ComfyUI generation pass -- always prompt-architect first, then generate

---

## Upgrade Path (Candidate -> Full Skill)

This skill gets upgraded when:
1. Pylon (Mac Mini, June 2026) is online -- add local video diffusion model specs
2. A free text-to-video API is confirmed -- add model-specific parameter sections
3. Mystique accumulates 10+ approved generations -- add style DNA injection from calibration/

Current status: CANDIDATE. Works today for static image gen. Video section pending tool lock-in.
