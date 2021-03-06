import java.util.List;

private class NexusBeams {

    private final List<Beam> mBeams;
    private final IntList mColours;

    NexusBeams() {
        mBeams = new ArrayList<Beam>();
        mColours = new IntList();
        for (int i = 0; i < COLOURS.length; i++) {
            mColours.append(i);
        }
    }

    void update() {
        if (nextInt(BEAM_CHANCE_OF_FIRING) == 0) {
            mBeams.add(createNewBeam());
        }
        for (int i = mBeams.size() - 1; i >= 0; i--) {
            mBeams.get(i).move();
            if (mBeams.get(i).isGone()) {
                mBeams.remove(i);
            }
        }
    }

    void draw() {
        for (Beam beam : mBeams) {
            beam.draw();
        }
    }

    void createTouchBeams(int touchX, int touchY) {
        for (Beam touchBeam : createNewTouchBeams(touchX, touchY)) {
            mBeams.add(touchBeam);
        }
    }

    private Beam createNewBeam() {
        switch (Direction.getRandomDirection()) {
            case UP:
                return new UpwardsBeam(BeamType.getRandomBeamType());
            case DOWN:
                return new DownwardsBeam(BeamType.getRandomBeamType());
            case LEFT:
                return new LeftwardsBeam(BeamType.getRandomBeamType());
            case RIGHT:
                return new RightwardsBeam(BeamType.getRandomBeamType());
            default: // Should never happen
                println("Fatal error: Returned an invalid beam direction");
                exit();
                return null;
        }
    }

    private Beam[] createNewTouchBeams(int touchX, int touchY) {
        mColours.shuffle();
        BeamType beamtype = BeamType.getRandomBeamType();
        PVector origin = new PVector(touchX, touchY);
        return new Beam[] {
            new UpwardsBeam(beamtype, origin, mColours.get(0)),
            new DownwardsBeam(beamtype, origin, mColours.get(1)),
            new LeftwardsBeam(beamtype, origin, mColours.get(2)),
            new RightwardsBeam(beamtype, origin, mColours.get(3))
        };
    }
}
