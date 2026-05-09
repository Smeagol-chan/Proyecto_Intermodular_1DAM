package org.example.demo.roomie.properties;

public enum RoomType
{
    KITCHEN(true, "Kitchen"),
    LIVING_ROOM(true, "Living Room"),
    BALCONY(true, "Balcony"),
    BATHROOM(true, "Bathroom"),
    HALL(true, "Hall"),
    BEDROOM(false, "Bedroom"),
    DINNING_ROOM(true, "Dinning Room"),
    STORAGE_ROOM(true, "Storage Room");

    private final boolean sharedSpace;
    private final String roomName;

    RoomType(boolean sharedSpace, String roomName)
    {
        this.sharedSpace = sharedSpace;
        this.roomName = roomName;
    }

    public boolean getSharedSpace() {
        return sharedSpace;
    }

    public String getRoomName() {
        return roomName;
    }
}
